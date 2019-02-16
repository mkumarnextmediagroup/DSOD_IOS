//
//  NotificationsViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/8.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "NotificationsViewController.h"
#import "Proto.h"
#import "UIViewController+myextend.h"
#import "NotificationsTableViewCell.h"

@interface NotificationsViewController ()<UITableViewDelegate,UITableViewDataSource,NotificationsTableViewCellDelegate>
{
    //table view
    UITableView *myTable;
}
@end

@implementation NotificationsViewController

/**
 build views
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UINavigationItem *item = [self navigationItem];
    item.leftBarButtonItem = [self navBarBack:self action:@selector(back)];
    item.title = @"NOTIFICATIONS";
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT] install];
    [myTable registerClass:[NotificationsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NotificationsTableViewCell class])];
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
 numberOfRowsInSection
 
 @param tableView UITableView
 @param section section index
 @return number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    NotificationsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotificationsTableViewCell class]) forIndexPath:indexPath];
    cell.delegate=self;
    cell.indexPath=indexPath;
    if (indexPath.row==0) {
        [cell setModel:@"UNITE Magazine" des:@"Enable notifications" status:_model.uniteMagazine];
    }else if (indexPath.row==1) {
        [cell setModel:@"Education" des:@"Enable notifications" status:_model.education];
    }else if (indexPath.row==2) {
        [cell setModel:@"Events" des:@"Enable notifications" status:_model.events];
    }else if (indexPath.row==3) {
        [cell setModel:@"Career" des:@"Enable notifications" status:_model.career];
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
}

/**
 status change event
 
 @param status ON is YES，OFF is NO
 @param indexPath NSIndexPath
 @param view UITableViewCell
 */
-(void)SwitchChangeAction:(BOOL)status indexPath:(NSIndexPath *)indexPath view:(UIView *)view
{
    [self showLoading];
    if (indexPath.row==0) {
        [Proto addNotificationsUniteMagazine:status completed:^(HttpResult *result) {
            [self hideLoading];
            if (result.OK) {
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:status];
            }else{
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:!status];
            }
        }];
    }else if (indexPath.row==1) {
        [Proto addNotificationsEducation:status completed:^(HttpResult *result) {
            [self hideLoading];
            if (result.OK) {
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:status];
            }else{
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:!status];
            }
        }];
    }else if (indexPath.row==2) {
        [Proto addNotificationsEvents:status completed:^(HttpResult *result) {
            [self hideLoading];
            if (result.OK) {
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:status];
            }else{
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:!status];
            }
        }];
    }else if (indexPath.row==3) {
        [Proto addNotificationsCareer:status completed:^(HttpResult *result) {
            [self hideLoading];
            if (result.OK) {
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
                [cell setModelSwitch:status];
            }else{
                NotificationsTableViewCell *cell =(NotificationsTableViewCell *)view;
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
