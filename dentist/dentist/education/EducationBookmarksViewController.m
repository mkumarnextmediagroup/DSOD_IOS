//
//  EducationBookmarksViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/29.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationBookmarksViewController.h"
#import "CourseTableViewCell.h"
#import "Common.h"
#import "Proto.h"
#import "GenericCoursesModel.h"
#import "CourseDetailViewController.h"

@interface EducationBookmarksViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation EducationBookmarksViewController{
    int edge;
    
    UIView *emptyView;
    
    UITableView *tableView;
    
    UIActivityIndicatorView *iv;
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
    
    NSMutableArray<GenericCoursesModel*> *courseModelArray;
    int currPage;
}

/**
 view did load
 add navigation bar
 build views
 */
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addNavBar];
    
    [self buildViews];
}

/**
 viewWillAppear
 call loadData
 离开当前界面后，页面的数据可能发生了变化，所以每次进入更新数据
 After leaving the current interface, the data of the page may change, so every time you enter the update data

 @param animated animated
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getDatas:NO];
}

/**
 build views
 table view 、loading view 、empty view
 */
-(void)buildViews{
    
    edge = 18;
    self.view.backgroundColor = rgbHex(0xf3f4f5);
    
    //table view
    tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 1000;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = argbHex(0x00000000);

    [tableView registerClass:CourseTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CourseTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] bottomParent:0] install];
    
    //loading view
    [self setupRefresh];

    //empty view
    [self buildEmptyView];
}

/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"BOOKMARKS";
    
//    iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    iv.tag = 998;
//    iv.backgroundColor = [UIColor clearColor];
//    iv.center = item.rightBarButtonItem.customView.center;
//    UIBarButtonItem *ivItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
//    self.navigationItem.rightBarButtonItem  = ivItem;
}

/**
 build empty view ,default hidden is YES;
 */
-(void)buildEmptyView{
    emptyView = tableView.addView;
    emptyView.userInteractionEnabled = NO;
    [[[[emptyView.layoutMaker topParent:0] leftParent:0]widthEq:SCREENWIDTH]install];
    
    UIImageView *illustrationIV = emptyView.addImageView;
    illustrationIV.imageName = @"img_lms_bookmarks_illustration";
    [[[illustrationIV.layoutMaker topParent:100]centerXParent:0]install];
    
    UILabel *noBookmarksLabel = emptyView.addLabel;
    noBookmarksLabel.text = @"No Bookmarks";
    noBookmarksLabel.textColor = rgbHex(0x4A4A4A);
    noBookmarksLabel.font = [Fonts regular:20];
    noBookmarksLabel.textAlignment = NSTextAlignmentCenter;
    [[[noBookmarksLabel.layoutMaker below:illustrationIV offset:40] centerXParent:0]install];
    
    UILabel *tipsLabel = emptyView.addLabel;
    tipsLabel.text = @"Courses you add to bookmarks\n will be kept here.";
    tipsLabel.textColor = rgbHex(0x4A4A4A);
    tipsLabel.font = [Fonts regular:16];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [[[tipsLabel.layoutMaker below:noBookmarksLabel offset:15] centerXParent:0]install];

    emptyView.hidden = YES;
}


/**
 setup tableview refresh event
 */
-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    [self firstRefresh];
}


/**
 show loading
 */
- (void)showTopIndicator {
//    iv.hidden = NO;
//    [iv startAnimating];
    
    isRefreshing = YES;
    [self showLoading];
}

/**
 stop loading
 */
- (void)hideTopIndicator {
//    iv.hidden = YES;
//    [iv stopAnimating];
    
    isRefreshing = NO;
    [self hideLoading];
}

/**
 first load data
 */
-(void)firstRefresh{
    [self getDatas:NO];
    [refreshControl endRefreshing];
}


/**
 get my bookmarked courses from server
 
 @param isMore whether loading more
 */
-(void)getDatas:(BOOL)isMore{
    if(isRefreshing){
        return;
    }
    
    currPage = isMore ? currPage + 1 : 1;
    
    [self showTopIndicator];
    [Proto lmsQueryBookmarks:isMore?currPage++:1 completed:^(BOOL success, NSString *msg, NSArray<BookmarkModel *> *array) {
        [self reloadData:[array copy]  isMore:isMore];
        [self hideTopIndicator];
    }];
}

/**
 table view reload data
 Update data source
 Refresh empty view
 
 @param newDatas new data
 @param isMore whether loading more
 */
-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(isMore){
        [courseModelArray addObjectsFromArray:newDatas?newDatas:@[]];
    }else{
        courseModelArray = [NSMutableArray arrayWithArray:newDatas];
    }
    [tableView reloadData];
    
    emptyView.hidden = courseModelArray&&courseModelArray.count>0;
}



#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 heightForHeaderInSection
 
 @param tableView UITableView
 @param section section index
 @return height for header in section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

/**
 UITableViewDataSource
 viewForHeaderInSection
 
 @param tableView UITableView
 @param section section index
 @return UIView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
//    headerView.backgroundColor = UIColor.redColor;
    return headerView;
}


/**
 UITableViewDataSource
 numberOfSectionsInTableView
 
 @param tableView UITableView
 @return number of sections
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return courseModelArray.count;
}


/**
 UITableViewDataSource
 cellForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CourseTableViewCell.class) forIndexPath:indexPath];
    cell.model = courseModelArray[indexPath.row];
    cell.vc = self;
    cell.bookmarkStatusChanged = ^(GenericCoursesModel *model){
        [self->courseModelArray removeObject:model];
        [self->tableView reloadData];
    };
    
    return cell;
}

/**
 UITableViewDelegate
 didSelectRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [CourseDetailViewController presentBy:self courseId:courseModelArray[indexPath.row].id];
}

/**
 Handling paged load data
 
 @param scrollView UIScrollView
 @param decelerate BOOL
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
}



@end
