//
//  SponsoredCourseViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/20.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "SponsoredCourseViewController.h"
#import "Proto.h"
#import "Common.h"
#import "GenericCoursesModel.h"
#import "CourseTableViewCell.h"
#import "CourseDetailViewController.h"

@interface SponsoredCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray<GenericCoursesModel *> *infoArr;
}
@end

@implementation SponsoredCourseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title=@"LEARNING";
    
    item.leftBarButtonItem = [self navBarBack:self action:@selector(back)];
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTable.backgroundColor = Colors.textColorFAFBFD;
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 200;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.tableHeaderView=[self makeHeaderView];
    [myTable registerClass:[CourseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CourseTableViewCell class])];
    [[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:_topBarH] bottomParent:-_bottomBarH] install];
    [self setupRefresh];
    [self refreshData];
    // Do any additional setup after loading the view.
}

/**
 table header view
 display sponsor image & banner
 */
- (UIView *)makeHeaderView {
    
    UIView *panel = [UIView new];
    CGFloat ivimgh=((420/750.0)*SCREENWIDTH);
    CGFloat sponstorimgh=((50.0/375.0)*SCREENWIDTH);
    panel.frame = makeRect(0, 0, SCREENWIDTH, ivimgh+sponstorimgh);
    UIImageView *iv = [panel addImageView];
    [iv scaleFillAspect];
    iv.imageName = @"GSKPic";
    if ([_sponsorId isEqualToString:@"260"]) {
        iv.imageName = @"sponsor_align_banner";
    }else if ([_sponsorId isEqualToString:@"259"]) {
        iv.imageName = @"sponsor_nobel_banner";
    }else if([_sponsorId isEqualToString:@"197"]){
        iv.imageName = @"sponsor_gsk_banner";
    }else{
        iv.imageName = @"GSKPic";
    }
    [[[[[[iv layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:ivimgh] install];
    UIButton *gskBtn=panel.addButton;
    [[[[[gskBtn.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:sponstorimgh] install] ;
    
    NSDictionary *sponsorInfo = @{@"260":@"sponsor_align",
                                  @"259":@"sponsor_nobel",
                                  @"197":@"sponsor_gsk"};
    NSString *sponsorimgname=@"sponsor_gsk";
    if (sponsorInfo[_sponsorId]) {
        sponsorimgname=sponsorInfo[_sponsorId];
    }
    [gskBtn setBackgroundImage:[UIImage imageNamed:sponsorimgname] forState:UIControlStateNormal];
    
    return panel;
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
    [Proto queryLMSGenericCourses:1 pagesize:20 curriculumId:nil categoryId:nil featured:-1 sponsoredId:_sponsorId isSponsored:-1 completed:^(NSArray<GenericCoursesModel *> *array) {
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
    UILabel *categorylabel=[bgview addLabel];
    categorylabel.textColor=Colors.black1A191A;
    categorylabel.font=[Fonts regular:17];
    [[[[[categorylabel.layoutMaker leftParent:16] rightParent:0] topParent:0] heightEq:50] install];
    categorylabel.text=@"Sponsored";
    
    return bgview;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseTableViewCell class]) forIndexPath:indexPath];
    cell.isHideSponsor=YES;
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        GenericCoursesModel *model=self->infoArr[indexPath.row];
        cell.model=model;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        GenericCoursesModel *model=self->infoArr[indexPath.row];
        if (model) {
            [CourseDetailViewController presentBy:self courseId:model.id];
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
