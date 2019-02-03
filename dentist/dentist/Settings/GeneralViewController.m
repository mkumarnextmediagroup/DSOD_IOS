//
//  GeneralViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/11.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "GeneralViewController.h"
#import "Common.h"
#import "GeneralTableViewCell.h"
#import "VideoQualityViewController.h"
#import "PlaybackSpeedViewController.h"
#import "Proto.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface GeneralViewController ()<UITableViewDelegate,UITableViewDataSource,GeneralTableViewCellDelegate>
{
    NSArray *infoArr;
    NSArray *infoArr2;
    NSArray *infoArr3;
    UITableView *myTable;
    BOOL isSupportFaceId;
}
@end

@implementation GeneralViewController


/**
 build views
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL qq=nil;
    if (qq==YES) {
        NSLog(@"qq==Yes");
    }
    if (qq==NO) {
        NSLog(@"qq==no");
    }
    
    infoArr = [NSArray arrayWithObjects:@{@"title":@"Use Face ID",@"des":@"Use Face ID to login"},@{@"title":@"Use DSODentist offline",@"des":@"if it's on,app will not use Wi-Fi or cellular data"}, nil];
    infoArr2 = [NSArray arrayWithObjects:@{@"title":@"Video download quality",@"des":@"auto"},@{@"title":@"Playback Speed",@"des":@"1.0 x"}, nil];
    infoArr3 = [NSArray arrayWithObjects:@{@"title":@"Download over Wi-Fi only",@"des":@"Allow to download contents over Wi-Fi only"}, nil];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"GENERAL";
     item.leftBarButtonItem = [self navBarBack:self action:@selector(back)];
    //    item.rightBarButtonItems = @[
    //        [self navBarText:@"Logout" target:self action:@selector(onClickLogout:)]
    //    ];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.backgroundColor = [UIColor whiteColor];
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    [myTable registerClass:[GeneralTableViewCell class] forCellReuseIdentifier:NSStringFromClass([GeneralTableViewCell class])];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    LAContext *context = [[LAContext alloc] init];
    //判断是支持touchid还是faceid
    if (@available(iOS 11.0, *)) {
        switch (context.biometryType) {
            case LABiometryNone:
                NSLog(@"-----------touchid，faceid都不支持");
                break;
            case LABiometryTypeTouchID:
                NSLog(@"-----------touchid支持");
                break;
            case LABiometryTypeFaceID:
                NSLog(@"-----------faceid支持");
                isSupportFaceId=YES;
                break;
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
        NSLog(@"-----------iOS11之前的版本，不做id判断");
    }
    _model.videoDownloadQuality=[VideoQualityViewController getCheckedVideoQualityText];
    _model.playbackSpeed=[PlaybackSpeedViewController getCheckedPlaybackSpeedText];
//    infoArr2 = [NSArray arrayWithObjects:
//                @{@"title":@"Video download quality",@"des":[VideoQualityViewController getCheckedVideoQualityText]},
//                @{@"title":@"Playback Speed",@"des":[PlaybackSpeedViewController getCheckedPlaybackSpeedText]}, nil];
    [myTable reloadData];
    
}


/**
 close page
 */
-(void)back{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 heightForRowAtIndexPath

 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/**
 UITableViewDataSource
 numberOfSectionsInTableView

 @param tableView UITableView
 @return number of sections
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

/**
 UITableViewDataSource
 heightForHeaderInSection

 @param tableView UITableView
 @param section section index
 @return height for header in section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        return 40;
    }
}


/**
 UITableViewDataSource
 viewForHeaderInSection

 @param tableView UITableView
 @param section section index
 @return UIView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return [UIView new];
    }else{
        UIView *bgview=[UIView new];
        bgview.backgroundColor=Colors.textColorFAFBFD;
       UILabel *desLabel = bgview.addLabel;
        desLabel.font = [Fonts regular:13];
        desLabel.textColor = Colors.textDisabled;
        [[[[[desLabel.layoutMaker topParent:0] leftParent:20] rightParent:0] bottomParent:0] install];
        if (section==1) {
            desLabel.text=@"Video Options";
        }else if (section==2){
            desLabel.text=@"Download Options";
        }
        return bgview;
    }
    
}

/**
 UITableViewDataSource
 numberOfRowsInSection

 @param tableView UITableView
 @param section section index
 @return number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return infoArr.count;
    }else if(section==1){
        return infoArr2.count;
    }else{
        return infoArr3.count;
    }
    
}
/**
 UITableViewDataSource
 cellForRowAtIndexPath

 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeneralTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GeneralTableViewCell class]) forIndexPath:indexPath];
    cell.delegate=self;
    cell.indexPath=indexPath;
    if (indexPath.section==0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if(infoArr.count>indexPath.row){
            NSDictionary *dic=infoArr[indexPath.row];
            if (indexPath.row==0) {
                if (!isSupportFaceId) {
                    [cell styleGlay];
                }
                [cell setModel:[dic objectForKey:@"title"] des:[dic objectForKey:@"des"] status:(isSupportFaceId?_model.useFaceID:NO)];
            }else if (indexPath.row==1){
                [cell setModel:[dic objectForKey:@"title"] des:[dic objectForKey:@"des"] status:_model.useDsoDentistOffline];
            }
            
        }
        
    }else if (indexPath.section==1){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.isSwitch=NO;
        if(infoArr2.count>indexPath.row){
            NSDictionary *dic=infoArr2[indexPath.row];
            if (indexPath.row==0) {
                cell.isShowTopLine=YES;
                [cell setModel:[dic objectForKey:@"title"] des:_model.videoDownloadQuality status:YES];
            }else if (indexPath.row==1){
                [cell setModel:[dic objectForKey:@"title"] des:_model.playbackSpeed status:YES];
            }
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.isShowTopLine=YES;
        if(infoArr3.count>indexPath.row){
            NSDictionary *dic=infoArr3[indexPath.row];
            [cell setModel:[dic objectForKey:@"title"] des:[dic objectForKey:@"des"] status:_model.downloadOnlyWiFi];
        }
    }
    return cell;
}

/**
 UITableViewDataSource
 didSelectRowAtIndexPath

 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==1){
        if (indexPath.row==0) {
            [VideoQualityViewController openBy:self];
        }else if (indexPath.row==1){
            [PlaybackSpeedViewController openBy:self];
        }
    }
}

/**
 status change event

 @param status ON is YES，OFF is NO
 @param indexPath NSIndexPath
 @param view UITableViewCell
 */
-(void)SwitchChangeAction:(BOOL)status indexPath:(NSIndexPath *)indexPath view:(UIView *)view
{
    if (indexPath.section==0) {
        if (indexPath.row==0 && isSupportFaceId) {
            [self showLoading];
            [Proto addGeneralsettingsUseFaceID:status completed:^(HttpResult *result) {
                [self hideLoading];
                if (result.OK) {
                    GeneralTableViewCell *cell =(GeneralTableViewCell *)view;
                    [cell setModelSwitch:status];
                }else{
                    GeneralTableViewCell *cell =(GeneralTableViewCell *)view;
                    [cell setModelSwitch:!status];
                }
            }];
        }else if (indexPath.row==1){
            [self showLoading];
            [Proto addGeneralsettingsUseDsoDentistOffline:status completed:^(HttpResult *result) {
                [self hideLoading];
                if (result.OK) {
                    GeneralTableViewCell *cell =(GeneralTableViewCell *)view;
                    [cell setModelSwitch:status];
                }else{
                    GeneralTableViewCell *cell =(GeneralTableViewCell *)view;
                    [cell setModelSwitch:!status];
                }
            }];
        }
        
    }else if (indexPath.section==2){
        [self showLoading];
        [Proto addGeneralsettingsDownloadOnlyWiFi:status completed:^(HttpResult *result) {
            [self hideLoading];
            if (result.OK) {
                GeneralTableViewCell *cell =(GeneralTableViewCell *)view;
                [cell setModelSwitch:status];
            }else{
                GeneralTableViewCell *cell =(GeneralTableViewCell *)view;
                [cell setModelSwitch:!status];
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
