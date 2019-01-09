//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SettingController.h"
#import "IIViewDeckController.h"
#import "Proto.h"
#import "AppDelegate.h"
#import "SettingTableViewCell.h"
#import "AboutViewController.h"
#import "VideoQualityViewController.h"
#import "PlaybackSpeedViewController.h"
#import <Social/Social.h>
#import "NotificationsViewController.h"

#define edge 18
@interface SettingController()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageArr;
    NSArray *infoArr;
    NSArray *imageArr2;
    NSArray *infoArr2;
    UITableView *myTable;
}
@end

@implementation SettingController {
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UILabel *lb = self.view.addLabel;
	lb.text = @"Setting Page";
	[lb textColorMain];
    imageArr = [NSArray arrayWithObjects:@"Setting_general",@"Setting_notifications",@"Setting_feedback",@"Setting_about",@"Setting_resetpwd",@"Setting_share", nil];
    infoArr = [NSArray arrayWithObjects:@"General",@"Notifications",@"Feedback and support",@"About",@"Change password",@"Share app", nil];
    imageArr2 = [NSArray arrayWithObjects:@"Setting_logout", nil];
    infoArr2 = [NSArray arrayWithObjects:@"Sign Out", nil];
	[[[lb.layoutMaker centerParent] sizeFit] install];

	UINavigationItem *item = [self navigationItem];
	item.title = @"SETTING";
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == infoArr.count-1) {
//        return 160;
//    }
    return 55;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        return 100;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return infoArr.count;
    }else{
        return infoArr2.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = @"cell";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        NSString *imageName = imageArr[indexPath.row];
        UIImage *imageCurr = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
        [cell setImageAndTitle:imageCurr title:infoArr[indexPath.row]];
    }else{
        NSString *imageName = imageArr2[indexPath.row];
        UIImage *imageCurr = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setLastCellImageAndTitle:imageCurr title:infoArr2[indexPath.row]];
//        if (indexPath.row == infoArr2.count-1) {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            [cell setLastCellImageAndTitle:imageCurr title:infoArr2[indexPath.row]];
//        }else
//        {
//            [cell setImageAndTitle:imageCurr title:infoArr2[indexPath.row]];
//        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
            {
                NotificationsViewController *notificationvc=[NotificationsViewController new];
                [self.navigationController pushViewController:notificationvc animated:YES];
            }
                
                break;
            case 2:
            {
                NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/twitter/id%@?mt=8",DENTISTAPPID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
                break;
            case 3:
                [AboutViewController openBy:self];
                break;
            case 4:
                break;
            case 5:
            {
                NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/twitter/id%@?mt=8",DENTISTAPPID];
                NSURL *shareurl = [NSURL URLWithString:urlStr];
                NSArray *activityItems = @[shareurl,@"DSODentist"];
                
                UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                [self presentViewController:avc animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sign Out" message:@"Are you sure that you want to sign out from the app" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [Proto logout];
            AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [delegate switchToWelcomePage];
            LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
            [linkedIn logout];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

- (void)onClickLogout:(id)sender {
	[Proto logout];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate switchToWelcomePage];
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    [linkedIn logout];
}

- (void)onClickEdit:(id)sender {
}
@end
