//
//  EducationCoursesViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/29.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationCoursesViewController.h"
#import "Proto.h"
#import "Common.h"
#import "CourseTableViewCell.h"
#import "CourseDetailViewController.h"
#import "EducationSearchViewController.h"
#import "LMSEnrollmentModel.h"

@interface EducationCoursesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray<LMSEnrollmentModel *> *infoArr;
}

@end

@implementation EducationCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"MY COURSES";
    
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    myTable = [UITableView new];
    myTable.backgroundColor = Colors.textColorFAFBFD;
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 200;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTable registerClass:[CourseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CourseTableViewCell class])];
    [[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:_topBarH] bottomParent:-_bottomBarH] install];
    [self setupRefresh];
    [self refreshData];
}

/**
 go to search page
 */
-(void)searchClick
{
    EducationSearchViewController *searchview=[EducationSearchViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchview];
    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navVC animated:NO completion:NULL];
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

/**
 查询课程列表
 query course list event
 */
-(void)refreshData
{
    [self showIndicator];
    [Proto queryLMSUserEnrollmentsCourses:0 completed:^(NSArray<LMSEnrollmentModel *> *array) {
        [self hideIndicator];
        NSLog(@"%@",array);
        self->infoArr = [NSMutableArray arrayWithArray:array];
        [self->myTable reloadData];
    }];
}

//MARK: 下拉刷新//
/**
 Pull down to refresh
 */
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self->myTable addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}


//MARK: 下拉刷新触发,在此获取数据
/**
 Pull down to refresh event
 */
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    [self refreshData];
    [refreshControl endRefreshing];
}

#pragma mark ----UITableViewDataSource & UITableViewDelegate

/**
 UITableViewDataSource
 numberOfSectionsInTableView
 
 @param tableView UITableView
 @return number of sections
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    return 15;
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
    return [UIView new];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseTableViewCell class]) forIndexPath:indexPath];
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        LMSEnrollmentModel *enrollmentmodel=self->infoArr[indexPath.row];
        GenericCoursesModel *model=enrollmentmodel.course;
        cell.model=model;
        cell.vc = self;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        LMSEnrollmentModel *enrollmentmodel=self->infoArr[indexPath.row];
        if (enrollmentmodel) {
            [CourseDetailViewController presentBy:self courseId:enrollmentmodel.courseId];
        }
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
