//
//  CareerFindJobViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerFindJobViewController.h"
#import "Proto.h"


@interface CareerFindJobViewController ()

@end

@implementation CareerFindJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"Find Job";
    
    [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array,NSInteger totalCount) {
        NSLog(@"totalCount=%@;jobarr=%@",@(totalCount),array);
    }];
    
    [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        NSLog(@"totalCount=%@;jobarr=%@",@(totalCount),array);
    }];
    
//    [Proto addJobApplication:@"5bfd0b22d6fe1747859ac1eb" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];
    
    [Proto queryJobBookmarks:0 completed:^(NSArray<JobBookmarkModel *> *array) {
        NSLog(@"jobarr=%@",array);
    }];
    
//    [Proto addJobBookmark:@"5bfcff05d6fe1747859ac1e1" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];
//
//    [Proto deleteJobBookmark:@"5bfe877bd6fe175342855843" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];

    // Do any additional setup after loading the view.
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
