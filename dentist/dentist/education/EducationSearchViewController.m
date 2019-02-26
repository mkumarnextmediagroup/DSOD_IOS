//
//  EducationSearchViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/13.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationSearchViewController.h"
#import "Common.h"
#import "Proto.h"
#import "GenericCoursesModel.h"
#import "CourseTableViewCell.h"
#import "CourseDetailViewController.h"

@interface EducationSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@end

@implementation EducationSearchViewController{
    int edge;

    UIView *emptyView;
    UILabel *tipsLabel;

    UISearchBar *searchBar;
    
    UITableView *tableView;

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
    [self showEmptyViewForDefault];
}

/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.rightBarButtonItem=nil;
    item.leftBarButtonItem=nil;
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.placeholder = @"Search...";
    searchBar.delegate = self;
    searchBar.showsCancelButton = NO;
    item.titleView = searchBar;
    
}

/**
 build empty view ,default hidden is YES;
 */
-(void)buildEmptyView{
    emptyView = tableView.addView;
    emptyView.userInteractionEnabled = NO;
    [[[[emptyView.layoutMaker topParent:0] leftParent:0]widthEq:SCREENWIDTH]install];
    
    UIImageView *illustrationIV = emptyView.addImageView;
    illustrationIV.imageName = @"img_lms_search_illustration";
    [[[illustrationIV.layoutMaker topParent:130]centerXParent:0]install];
    
    tipsLabel = emptyView.addLabel;
    tipsLabel.text = @"Search for course";
    tipsLabel.textColor = rgbHex(0x4A4A4A);
    tipsLabel.font = [Fonts regular:16];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [[[tipsLabel.layoutMaker below:illustrationIV offset:30] centerXParent:0]install];
    
    emptyView.hidden = YES;
}

/**
 display empty view, indicating "No content found matching search terms"
 */
-(void)showEmptyViewForNoMatching{
    tipsLabel.text = @"No content found matching\n search terms";
    emptyView.hidden = NO;
}

/**
 display empty view, indicating "Search for course"
 */
-(void)showEmptyViewForDefault{
    tipsLabel.text = @"Search for course";
    emptyView.hidden = NO;
}


/**
 setup tableview refresh event
 */
-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
}


/**
 show loading
 */
- (void)showTopIndicator {
    isRefreshing = YES;
    [self showLoading];
}

/**
 stop loading
 */
- (void)hideTopIndicator {
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
    NSString *keyword = searchBar.text;
    
    [self showTopIndicator];
    [Proto queryLMSGenericCourses:keyword pageNumber:isMore?currPage++:1 completed:^(NSArray<GenericCoursesModel *> *array) {
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
    
    if(courseModelArray&&courseModelArray.count>0){
        emptyView.hidden = YES;
    }else{
        [self showEmptyViewForNoMatching];
    }
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
    cell.isHideSponsor=YES;
    cell.vc = self;
    
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


#pragma mark ---UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
}


/**
 dismiss button clicked，do this method
 @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    
    [courseModelArray removeAllObjects];
    [tableView reloadData];
    [self showEmptyViewForDefault];

}

/**
 keyboard search button clicked，do this method
 @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self firstRefresh];
}



@end
