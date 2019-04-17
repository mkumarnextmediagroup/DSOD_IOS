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
#import "DentistTabView.h"
#import "EducationCategoryCourseViewController.h"
#import "CourseDetailViewController.h"
#import "YCMenuView.h"
#import "SponsoredCourseViewController.h"
#import "EducationSearchViewController.h"
#import "DentistHomeVC.h"
#import "BannerScrollView.h"

@interface EducationPage ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate,YCMenuViewDelegate,CourseTableViewCellDelegate>
{
    NSArray<GenericCoursesModel *> *infoArr;
    NSArray<GenericCoursesModel *> *infoArr2;
    NSArray<GenericCoursesModel *> *infoArr3;
    UITableView *myTable;
    UIView *panel;
    BannerScrollView *iv;
    DentistTabView *tabView;
    DentistTabView *toptabView;
    NSMutableArray<IdName *> *segItemsModel;
    NSMutableArray<IdName *> *childItemsModel;
    NSMutableArray<IdName *> *sponsorItemsModel;
    BOOL isCategoryType;
    NSInteger categorySelectIndex;
    
}
@end

@implementation EducationPage {

}


- (void)viewDidLoad {
	[super viewDidLoad];
    
    //test

	UINavigationItem *item = [self navigationItem];
	item.title = @"LEARNING";
//        item.rightBarButtonItems = @[
//            [self navBarText:@"see all" target:self action:@selector(goCategoryPage)]
//        ];
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    
    myTable =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    
    toptabView=[DentistTabView new];
    toptabView.isBackFistDelegate=NO;
    toptabView.delegate=self;
    [self.view addSubview:toptabView];
    toptabView.hidden=YES;
    [[[[[toptabView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] heightEq:51] install];
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
//    [iv addWithImageNames:urls autoTimerInterval:3 clickBlock:^(NSInteger index) {
//        NSLog(@"index=%@",@(index));
//        //可以做点击处理
//        //        [weakself showImageBrowser:index-1];
//    }];
    [iv addWithImageNames:urls courses:self->infoArr2 autoTimerInterval:3 clickBlock:^(NSInteger index) {

    }];
    
    UILabel *categorylabel=[panel addLabel];
    categorylabel.text=@"Categories";
    categorylabel.textColor=Colors.black1A191A;
    categorylabel.font=[Fonts regular:17];
    [[[[[categorylabel.layoutMaker leftParent:edg] rightParent:0] below:iv offset:20] heightEq:20] install];
    
    tabView=[DentistTabView new];
    tabView.isBackFistDelegate=NO;
    tabView.delegate=self;
    [panel addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] below:categorylabel offset:10] heightEq:51] install];
    
    return panel;
}

/**
 go to search page
 */
-(void)searchClick
{
    DentistHomeVC *searchview=[DentistHomeVC new];
//    EducationSearchViewController *searchview=[EducationSearchViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchview];
    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navVC animated:NO completion:NULL];
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
 go to sponsored course page
 @param sponsorId sponsor id
 */
-(void)goSponsoredCoursePage:(NSString *)sponsorId
{
    SponsoredCourseViewController *courseview=[SponsoredCourseViewController new];
    courseview.sponsorId=sponsorId;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:courseview];
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
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:categorycourseview];
    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navVC animated:NO completion:NULL];
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
        IdName *latestmodel1=[IdName new];
        latestmodel1.id=@"1";
        latestmodel1.name=@"SPONSORED";
        NSMutableArray *filterArray = [NSMutableArray arrayWithArray:array];
        for (int i = 0; i < array.count - 1; i++) {
            IdName *object = [array objectAtIndex:i];
            if (object.name == nil) {
                [filterArray removeObject:object];
            }
            NSLog(@"%d", object.name);
        }
        NSLog(@"%d", filterArray);
        self->segItemsModel=[NSMutableArray arrayWithArray:filterArray];
        IdName *latestmodel=[IdName new];
        latestmodel.id=@"0";
        latestmodel.name=@"FEATURED";
        [self->segItemsModel insertObject:latestmodel atIndex:0];
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
        self->toptabView.modelArr=self->segItemsModel;
        NSArray *urls = @[
                          @"slide-1",
                          @"slide-2",
                          @"slide-3",
                          @"slide-4",
                          @"slide-5"];
        [self->iv replaceImageNames:urls courses:self->infoArr2 clickBlock:^(NSInteger index) {
            
        }];
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
    if (self->isCategoryType) {
        return 1;
    }else{
       return 2;
    }
    
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
    if (self->isCategoryType) {
        return 0;
    }else{
        return 51;
    }
    
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
    if (!self->isCategoryType) {
        UIButton *seemorebtn=[bgview addButton];
        seemorebtn.tag=section;
        seemorebtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [seemorebtn setTitle:@"See More" forState:UIControlStateNormal];
        [seemorebtn setTitleColor:Colors.textDisabled forState:UIControlStateNormal];
        [[[[seemorebtn.layoutMaker rightParent:0] topParent:10] sizeEq:80 h:40] install];
        [seemorebtn addTarget:self action:@selector(seemoreAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *categorylabel=[bgview addLabel];
        categorylabel.textColor=Colors.black1A191A;
        categorylabel.font=[Fonts regular:17];
        [[[[[categorylabel.layoutMaker leftParent:16] toLeftOf:seemorebtn offset:-10] topParent:20] heightEq:20] install];
        if (section==0) {
            categorylabel.text=@"Courses you may like";
        }else{
            categorylabel.text=@"Latest Courses";
        }
    }
    
    
    return bgview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self->isCategoryType) {
        return infoArr3.count;
    }else{
        if(section==0){
            return infoArr.count;
        }else{
            return infoArr2.count;
        }
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseTableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.detegate=self;
    GenericCoursesModel *model;
    if (self->isCategoryType) {
        if (self->infoArr3 && self->infoArr3.count>indexPath.row) {
            model=self->infoArr3[indexPath.row];
            
        }
    }else{
        if (indexPath.section==0) {
            if (self->infoArr && self->infoArr.count>indexPath.row) {
                model=self->infoArr[indexPath.row];
                
            }
        }else{
            if (self->infoArr2 && self->infoArr2.count>indexPath.row) {
                model=self->infoArr2[indexPath.row];
            }
        }
    }
    
    cell.model=model;
    cell.vc = self;
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
    
    if([scrollView isEqual:self->myTable]){
        
        CGFloat bannerh=(343.0/718.0*SCREENWIDTH)+40+50;
        if(scrollView.contentOffset.y<bannerh){
            self->toptabView.hidden=YES;
        }else{
            self->toptabView.hidden=NO;
        }
        
    }
    
}

#pragma mark ------DentistTabViewDelegate
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    self->categorySelectIndex=index;
    if (self->segItemsModel.count>index) {
        IdName *model=self->segItemsModel[index];
        if ([model.id isEqualToString:@"0"]) {
            //FEATURE
            self->isCategoryType=NO;
            [self refreshData];
        }else if ([model.id isEqualToString:@"1"]) {
            //SPONSORED
            self->isCategoryType=NO;
            //供应商选择器
            IdName *align=[[IdName alloc] init];
            align.id=@"260";
            align.name=@"Align Technology";
            IdName *gsk=[[IdName alloc] init];
            gsk.id=@"197";
            gsk.name=@"GlaxoSmithKline";
            IdName *nobel=[[IdName alloc] init];
            nobel.id=@"259";
            nobel.name=@"Nobel Biocare";
            self->sponsorItemsModel=[NSMutableArray arrayWithArray:@[align,gsk,nobel]];
            YCMenuView *view = [YCMenuView menuWithArray:self->sponsorItemsModel width:166 relyonView:self->tabView];
            view.delegate=self;
            view.maxDisplayCount = 5;
            
            [view show];
        }
        else{
            [self showLoading];
            [Proto queryLMSCategoryTypes:model.id completed:^(NSArray<IdName *> *array) {
                [self hideLoading];
                if(array && array.count>0){
                    self->childItemsModel=[NSMutableArray arrayWithArray:array];
                    YCMenuView *view = [YCMenuView menuWithArray:array width:166 relyonView:self->tabView];
                    view.delegate=self;
                    view.maxDisplayCount = 5;
                    
                    [view show];
                }else{
                    [Proto queryLMSGenericCourses:1 curriculumId:nil categoryId:model.id completed:^(NSArray<GenericCoursesModel *> *array) {
                        [self hideLoading];
                        self->isCategoryType=YES;
                        self->infoArr3 = [NSMutableArray arrayWithArray:array];
                        [self->myTable reloadData];
                        
                        
                    }];
                }
                
            }];
        }
        
    }
    
}

#pragma mark -------YCMenuViewDelegate
-(void)didYCMenuSelectItemAtIndex:(NSInteger)index
{
    if (self->childItemsModel.count>index && self->categorySelectIndex>1) {
        IdName *model=self->childItemsModel[index];
        [self showLoading];
        [Proto queryLMSGenericCourses:1 curriculumId:nil categoryId:model.id completed:^(NSArray<GenericCoursesModel *> *array) {
            [self hideLoading];
            self->isCategoryType=YES;
            self->infoArr3 = [NSMutableArray arrayWithArray:array];
            [self->myTable reloadData];
            
            
        }];
    }else if(self->categorySelectIndex==1){
        IdName *model=self->sponsorItemsModel[index];
        [self goSponsoredCoursePage:model.id];
    }
}

#pragma mark -------CourseTableViewCellDelegate
-(void)sponsoredAction:(NSIndexPath *)indexPath
{
    GenericCoursesModel *model;
    if (self->isCategoryType) {
        if (self->infoArr3 && self->infoArr3.count>indexPath.row) {
            model=self->infoArr3[indexPath.row];
            
        }
    }else{
        if (indexPath.section==0) {
            if (self->infoArr && self->infoArr.count>indexPath.row) {
                model=self->infoArr[indexPath.row];
                
            }
        }else{
            if (self->infoArr2 && self->infoArr2.count>indexPath.row) {
                model=self->infoArr2[indexPath.row];
            }
        }
    }
    if (model) {
        [self goSponsoredCoursePage:model.sponsoredId];
    }
    
}

@end
