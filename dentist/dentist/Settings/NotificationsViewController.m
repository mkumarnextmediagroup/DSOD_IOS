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
    UITableView *myTable;
}
@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_model==nil) {
        _model=[NotificationModel new];
        _model.userId=getLastAccount();
        _model.uniteMagazine=NO;
        _model.education=NO;
        _model.events=NO;
        _model.career=NO;
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotificationsTableViewCell class]) forIndexPath:indexPath];
    cell.delegate=self;
    cell.indexPath=indexPath;
    if (indexPath.row==0) {
        [cell setModel:@"Unite Magazine" des:@"Enable notifications" status:_model.uniteMagazine];
    }else if (indexPath.row==1) {
        [cell setModel:@"Education" des:@"Enable notifications" status:_model.education];
    }else if (indexPath.row==2) {
        [cell setModel:@"Events" des:@"Enable notifications" status:_model.events];
    }else if (indexPath.row==3) {
        [cell setModel:@"Career" des:@"Enable notifications" status:_model.career];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
