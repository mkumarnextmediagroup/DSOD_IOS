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
#import "CompanyDetailViewController.h"
#import "Proto.h"
#import "CompanyModel.h"
#import "CareerSearchViewController.h"

@interface DSOProfilePage ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray<CompanyModel *> *infoArr;
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
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-50] topParent:NAVHEIGHT] install];
    
    [self showCenterIndicator];
    [Proto queryCompanyList:0 completed:^(NSArray<CompanyModel *> *array, NSInteger totalCount) {
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
//    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//    CareerSearchViewController *searchVC=[CareerSearchViewController new];
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
//    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [viewController presentViewController:navVC animated:YES completion:NULL];
        CareerSearchViewController *searchVC=[CareerSearchViewController new];
        [self.navigationController pushViewController:searchVC animated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [CompanyDetailViewController openBy:viewController companyId:infoArr[indexPath.row].companyId];
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
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
