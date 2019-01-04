//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SettingController.h"
#import "IIViewDeckController.h"
#import "Proto.h"
#import "AppDelegate.h"
#import "SettingTableViewCell.h"

#define edge 18
@interface SettingController()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageArr;
    NSArray *infoArr;
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
    imageArr = [NSArray arrayWithObjects:@"Setting_general",@"Setting_notifications",@"Setting_feedback",@"Setting_about",@"Setting_resetpwd",@"Setting_share",@"Setting_logout", nil];
    infoArr = [NSArray arrayWithObjects:@"General",@"Notifications",@"Feedback and support",@"About",@"Change password",@"Share app",@"Sign Out", nil];
	[[[lb.layoutMaker centerParent] sizeFit] install];

	UINavigationItem *item = [self navigationItem];
	item.title = @"SETTING";
	item.rightBarButtonItems = @[
        [self navBarText:@"Logout" target:self action:@selector(onClickLogout:)]
	];

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
    if (indexPath.row == infoArr.count-1) {
        return 160;
    }
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = @"cell";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *imageName = imageArr[indexPath.row];
    UIImage *imageCurr = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
    if (indexPath.row == infoArr.count-1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setLastCellImageAndTitle:imageCurr title:infoArr[indexPath.row]];
    }else
    {
        [cell setImageAndTitle:imageCurr title:infoArr[indexPath.row]];
    }
    return cell;
    
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
