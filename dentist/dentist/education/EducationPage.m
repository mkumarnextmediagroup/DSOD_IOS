//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "EducationPage.h"
#import "Common.h"
#import "Proto.h"
#import "EducationCategoryViewController.h"
#import "LMSCategoryModel.h"
#import "CourseTableViewCell.h"
#import "BannerScrollView.h"
#import "DentistTabView.h"
#import "EducationCategoryCourseViewController.h"
#import "CourseDetailViewController.h"

@interface EducationPage ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate>
{
    NSArray<GenericCoursesModel *> *infoArr;
    NSArray<GenericCoursesModel *> *infoArr2;
    UITableView *myTable;
    UIView *panel;
    BannerScrollView *iv;
    DentistTabView *tabView;
    NSMutableArray<IdName *> *segItemsModel;
}
@end

@implementation EducationPage {

}


- (void)viewDidLoad {
	[super viewDidLoad];
    
    //test

	UINavigationItem *item = [self navigationItem];
	item.title = @"LEARNING";
        item.rightBarButtonItems = @[
            [self navBarText:@"see all" target:self action:@selector(goCategoryPage)]
        ];
    
    myTable =[UITableView new]; //[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.tableHeaderView=[self makeHeaderView];
    myTable.backgroundColor = Colors.textColorFAFBFD;;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 200;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    [myTable registerClass:[CourseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CourseTableViewCell class])];
    [self refreshData];


}

#pragma mark public method

/**
 表头视图
 table Header View
 */
- (UIView *)makeHeaderView {
    panel = [UIView new];
    CGFloat edg=16;
    CGFloat bannerh=(343.0/718.0*SCREENWIDTH);
    panel.frame = makeRect(0, 0, SCREENWIDTH, 40+bannerh+50+51);
    UIView *topbgview=[UIView new];
    [panel addSubview:topbgview];
    topbgview.backgroundColor=Colors.bgNavBarColor;
    [[[[[topbgview.layoutMaker topParent:0] leftParent:0] rightParent:0] heightEq:bannerh] install];
    
    NSArray *urls = @[
                      @"slide-1",
                      @"slide-2",
                      @"slide-3",
                      @"slide-4",
                      @"slide-5"];
    iv =[BannerScrollView new];
    [panel addSubview:iv];
    [[[[[[iv layoutMaker] leftParent:edg] rightParent:-edg] topParent:40] heightEq:bannerh] install];
    [iv addWithImageNames:urls autoTimerInterval:3 clickBlock:^(NSInteger index) {
        NSLog(@"index=%@",@(index));
        //可以做点击处理
        //        [weakself showImageBrowser:index-1];
    }];
    
    UILabel *categorylabel=[panel addLabel];
    categorylabel.text=@"Categories";
    categorylabel.textColor=Colors.black1A191A;
    categorylabel.font=[UIFont systemFontOfSize:17];
    [[[[[categorylabel.layoutMaker leftParent:edg] rightParent:0] below:iv offset:20] heightEq:20] install];
    
    tabView=[DentistTabView new];
    tabView.delegate=self;
    [panel addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] below:categorylabel offset:10] heightEq:51] install];
    
    return panel;
}

/**
 go to category page
 */
-(void)goCategoryPage
{
    EducationCategoryViewController *categoryview=[EducationCategoryViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:categoryview];
    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navVC animated:NO completion:NULL];
}

/**
 go to category course page
 */
-(void)seemoreAction:(UIButton *)sender
{
    NSInteger tag=sender.tag;
    EducationCategoryCourseViewController *categorycourseview=[EducationCategoryCourseViewController new];
    
    if (tag==0) {
        categorycourseview.coursetitle=@"Courses you may like";
        categorycourseview.isFeatured=YES;
    }else{
        categorycourseview.coursetitle=@"Latest Courses";
    }
    [self.navigationController pushViewController:categorycourseview animated:YES];
}


/**
 查询课程列表
 query course list event
 */
-(void)refreshData
{
    [self showLoading];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);
    [Proto queryLMSCategoryTypes:nil completed:^(NSArray<IdName *> *array) {
        self->segItemsModel=[NSMutableArray arrayWithArray:array];
        dispatch_group_leave(dispatchGroup);
    }];
    dispatch_group_enter(dispatchGroup);
    [Proto queryLMSFeaturedGenericCourses:1 pagesize:2 curriculumId:nil categoryId:nil completed:^(NSArray<GenericCoursesModel *> *array) {
        self->infoArr = [NSMutableArray arrayWithArray:array];
        dispatch_group_leave(dispatchGroup);
    }];
    dispatch_group_enter(dispatchGroup);
    [Proto queryLMSGenericCourses:1 pagesize:3 curriculumId:nil categoryId:nil completed:^(NSArray<GenericCoursesModel *> *array) {
        self->infoArr2 = [NSMutableArray arrayWithArray:array];
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        //处理完成更新列表详细信息
        NSLog(@"================总请求网络完成");
        [self hideLoading];
        self->tabView.modelArr=self->segItemsModel;
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
    return 50;
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
    UIButton *seemorebtn=[bgview addButton];
    seemorebtn.tag=section;
    seemorebtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [seemorebtn setTitle:@"See More" forState:UIControlStateNormal];
    [seemorebtn setTitleColor:Colors.textDisabled forState:UIControlStateNormal];
    [[[[seemorebtn.layoutMaker rightParent:0] topParent:10] sizeEq:80 h:40] install];
    [seemorebtn addTarget:self action:@selector(seemoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *categorylabel=[bgview addLabel];
    categorylabel.textColor=Colors.black1A191A;
    categorylabel.font=[UIFont systemFontOfSize:17];
    [[[[[categorylabel.layoutMaker leftParent:16] toLeftOf:seemorebtn offset:-10] topParent:20] heightEq:20] install];
    if (section==0) {
        categorylabel.text=@"Courses you may like";
    }else{
        categorylabel.text=@"Latest Courses";
    }
    return bgview;
    
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
    CourseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section==0) {
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            GenericCoursesModel *model=self->infoArr[indexPath.row];
            cell.model=model;
        }
    }else{
        if (self->infoArr2 && self->infoArr2.count>indexPath.row) {
            GenericCoursesModel *model=self->infoArr2[indexPath.row];
            cell.model=model;
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GenericCoursesModel *model;
    if (indexPath.section==0) {
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            model=self->infoArr[indexPath.row];
        }
    }else{
        if (self->infoArr2 && self->infoArr2.count>indexPath.row) {
            model=self->infoArr2[indexPath.row];
        }
    }
    if (model) {
        [CourseDetailViewController presentBy:self courseId:model.id];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    NSLog(@"%f",scrollView.contentOffset.y);
    
    CGFloat sectionHeaderHeight = 50;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

#pragma mark ------DentistTabViewDelegate
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    
}

@end
