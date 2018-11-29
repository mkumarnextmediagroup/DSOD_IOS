//
//  DSOProfilePage.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DSOProfilePage.h"
#import "Common.h"
#import "DSOProfileTableViewCell.h"
#import "CareerJobDetailViewController.h"
#import "Proto.h"
#import "JobModel.h"

@interface DSOProfilePage ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *infoArr;
    UITableView *myTable;
}
@end

@implementation DSOProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"DSO PROFILES";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.tableFooterView = [[UIView alloc]init];
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    
    [self showCenterIndicator];
    [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideCenterIndicator];
            NSLog(@"%@",array);
            self->infoArr = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->myTable reloadData];
            });

        });
    }];

    // Do any additional setup after loading the view.
}

- (void)searchClick
{
    NSLog(@"search btn click");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = @"cell";
    DSOProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[DSOProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell bindInfo:infoArr[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CareerJobDetailViewController *detail = [CareerJobDetailViewController new];
    [self.navigationController pushPage:detail];
}

- (void)onBack:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
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
