//
//  CompanyReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyReviewsViewController : UIViewController

@property (nonatomic,strong) JobDSOModel *jobDSOModel;


/**
 open reviews list of dso page
 
 @param vc UIViewController
 @param jobDSOModel jobDSOModel instance
 */
+ (void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel;
/**
 open reviews list of dso page
 
 @param vc UIViewController
 @param jobDSOModel jobDSOModel instance
 @param onReviewNumChanged Comment numbers change callback event
 */
+ (void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel onReviewNumChanged:(void(^)(NSInteger reviewNum))onReviewNumChanged;
/**
 view did load
 add navigation bar
 build views
 */
- (void)viewDidLoad;
/**
 add navigation bar
 */
- (void)addNavBar;
/**
 colse page
 If the number of comments changes, callback onReviewNumChanged function
 */
- (void)dismiss;
/**
 build views
 */
- (void)buildViews;
/**
 build header
 dso name、star、reivews numbers
 */
- (UIView*)buildHeader;
/**
 setup tableview refresh event
 */
- (void)setupRefresh;
/**
 show loading
 */
- (void)showTopIndicator;
/**
 stop loading
 */
- (void)hideTopIndicator;
/**
 first load data
 */
- (void)firstRefresh;
/**
 get data from server
 
 @param isMore whether loading more
 */
- (void)getDatas:(BOOL)isMore;
/**
 table view reload data
 Update data source
 Refresh form
 
 @param newDatas new data
 @param isMore whether loading more
 */
- (void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore;
/**
 write review button click event
 jump to write review page
 */
- (void)writeReview;
/**
 重置排序条件和过滤条件
 Reset sorting criteria and filters
 */
- (void)resetSortAndFilter;
/**
 排序条件点击事件
 初始化数据，弹出菜单
 Sorting condition click event
 Initialize data, popup menu
 
 @param view Responsive view
 */
- (void)sortOnClick:(UIView*)view;
/**
 过滤条件点击事件
 初始化数据，弹出菜单
 filter  click event
 Initialize data, popup menu
 
 @param view Responsive view
 */
- (void)filterOnClick:(UIView*)view;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 Handling paged load data
 
 @param scrollView UIScrollView
 @param decelerate BOOL
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

NS_ASSUME_NONNULL_END
