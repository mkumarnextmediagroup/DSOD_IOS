//
//  CareerFindJobViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerFindJobViewController.h"
#import "Proto.h"
#import "FindJobsTableViewCell.h"
#import "DSODetailPage.h"


@interface CareerFindJobViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *infoArr;
    UITableView *myTable;
}
@end

@implementation CareerFindJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"JOBS";
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTable registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            NSLog(@"%@",array);
            self->infoArr = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->myTable reloadData];
            });
            
        });
    }];
    
//    [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array,NSInteger totalCount) {
//        NSLog(@"totalCount=%@;jobarr=%@",@(totalCount),array);
//    }];
//
//    [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
//        NSLog(@"totalCount=%@;jobarr=%@",@(totalCount),array);
//    }];
    
//    [Proto addJobApplication:@"5bfd0b22d6fe1747859ac1eb" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];
    
//    [Proto queryJobBookmarks:0 completed:^(NSArray<JobBookmarkModel *> *array) {
//        NSLog(@"jobarr=%@",array);
//    }];
    
//    [Proto addJobBookmark:@"5bfcff05d6fe1747859ac1e1" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];
//
//    [Proto deleteJobBookmark:@"5bfe877bd6fe175342855843" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];

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
    FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        cell.info=self->infoArr[indexPath.row];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSODetailPage *detail = [DSODetailPage new];
    [self.navigationController pushPage:detail];
}


@end
