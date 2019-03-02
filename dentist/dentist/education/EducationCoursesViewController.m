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
#import "CourseEnrollmentTableViewCell.h"

@interface EducationCoursesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray<LMSEnrollmentModel *> *startArr;
    NSMutableArray<LMSEnrollmentModel *> *notstartArr;
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
    [myTable registerClass:[CourseEnrollmentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CourseEnrollmentTableViewCell class])];
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
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);
    [Proto queryLMSUserEnrollmentsCourses:1 completed:^(NSArray<LMSEnrollmentModel *> *array) {
        dispatch_group_leave(dispatchGroup);
        self->startArr = [NSMutableArray arrayWithArray:array];
    }];
    dispatch_group_enter(dispatchGroup);
    [Proto queryLMSUserEnrollmentsCourses:0 completed:^(NSArray<LMSEnrollmentModel *> *array) {
        dispatch_group_leave(dispatchGroup);
        self->notstartArr = [NSMutableArray arrayWithArray:array];
    }];
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        //处理完成更新列表详细信息
        NSLog(@"================总请求网络完成");
        [self hideLoading];
        [self->myTable reloadData];
    });
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
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
    return 60;
    
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
    UIView *bgview=[UIView new];
    UILabel *categorylabel=[bgview addLabel];
    categorylabel.textColor=Colors.black1A191A;
    categorylabel.font=[Fonts regular:17];
    [[[[[categorylabel.layoutMaker leftParent:16] rightParent:-16] topParent:0] heightEq:60] install];
    if (section==0) {
        categorylabel.text=@"Started";
    }else{
        categorylabel.text=@"Not Started";
    }
    
    return bgview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return startArr.count;
    }else{
        return notstartArr.count;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseEnrollmentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseEnrollmentTableViewCell class]) forIndexPath:indexPath];
    LMSEnrollmentModel *enrollmentmodel;
    if (indexPath.section==0) {
        if (self->startArr && self->startArr.count>indexPath.row) {
            enrollmentmodel=self->startArr[indexPath.row];
        }
    }else{
        if (self->notstartArr && self->notstartArr.count>indexPath.row) {
            enrollmentmodel=self->notstartArr[indexPath.row];
        }
    }
    cell.model=enrollmentmodel;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LMSEnrollmentModel *enrollmentmodel;
    if (indexPath.section==0) {
        if (self->startArr && self->startArr.count>indexPath.row) {
            enrollmentmodel=self->startArr[indexPath.row];
        }
    }else{
        if (self->notstartArr && self->notstartArr.count>indexPath.row) {
            enrollmentmodel=self->notstartArr[indexPath.row];
        }
    }
    if (enrollmentmodel) {
        [CourseDetailViewController presentBy:self courseId:enrollmentmodel.courseId];
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
