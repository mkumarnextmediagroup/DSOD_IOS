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

@interface GeneralViewController ()<UITableViewDelegate,UITableViewDataSource,GeneralTableViewCellDelegate>
{
    NSArray *infoArr;
    NSArray *infoArr2;
    NSArray *infoArr3;
    UITableView *myTable;
}
@end

@implementation GeneralViewController

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
    item.title = @"GENERAl";
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
    _model.videoDownloadQuality=[VideoQualityViewController getCheckedVideoQualityText];
    _model.playbackSpeed=[PlaybackSpeedViewController getCheckedPlaybackSpeedText];
//    infoArr2 = [NSArray arrayWithObjects:
//                @{@"title":@"Video download quality",@"des":[VideoQualityViewController getCheckedVideoQualityText]},
//                @{@"title":@"Playback Speed",@"des":[PlaybackSpeedViewController getCheckedPlaybackSpeedText]}, nil];
    [myTable reloadData];
    
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        return 40;
    }
}


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
                [cell setModel:[dic objectForKey:@"title"] des:[dic objectForKey:@"des"] status:_model.useFaceID];
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
                [cell setModel:[dic objectForKey:@"title"] des:_model.videoDownloadQuality status:YES];
            }else if (indexPath.row==1){
                [cell setModel:[dic objectForKey:@"title"] des:_model.playbackSpeed status:YES];
            }
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        if(infoArr3.count>indexPath.row){
            NSDictionary *dic=infoArr3[indexPath.row];
            [cell setModel:[dic objectForKey:@"title"] des:[dic objectForKey:@"des"] status:_model.downloadOnlyWiFi];
        }
    }
    return cell;
}

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

-(void)SwitchChangeAction:(BOOL)status indexPath:(NSIndexPath *)indexPath view:(UIView *)view
{
    [self showLoading];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
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
