//
//  CompanyExistsReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/16.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyExistsReviewsViewController : UIViewController

/**
 opne dso list page
 
 @param vc UIViewController
 */
+ (void)openBy:(UIViewController*)vc;
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
 返回上一页面
 back to the previous page
 */
- (void)backToFirst;
/**
 search click event
 jump to dso search page
 */
- (void)searchClick;
/**
 build views
 */
- (void)buildView;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 Handling paged load data
 
 @param scrollView UIScrollView
 @param decelerate BOOL
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
