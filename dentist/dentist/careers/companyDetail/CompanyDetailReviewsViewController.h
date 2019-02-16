//
//  CompanyDetailReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDSOModel.h"
#import "CompanyReviewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyDetailReviewsViewController : UIViewController

@property (nonatomic,assign) UIViewController *vc;
@property (nonatomic,strong) JobDSOModel *jobDSOModel;

// 是否可以滑动
//Is it currently possible to scroll
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
// Callback function when scrolling is not possible
@property (nonatomic, copy) void(^noScrollAction)(void) ;
/**
 滚动到初始位置
 Scroll to the initial position
 */
- (void)contentOffsetToPointZero;
/**
 view did load
 call buildview function
 */
- (void)viewDidLoad;
/**
 set JobDSOModel

 @param jobDSOModel JobDSOModel
 */
- (void)setJobDSOModel:(JobDSOModel *)jobDSOModel;
/**
 Reload comment data
 */
- (void)reloadComment;
/**
 获得最新的公司信息
 Get the latest dso information
 */
- (void)getNewJobDSOModel;
/**
 see more label click event
 jump to reviews list page
 */
- (void)seeMore;
/**
 Write review button click event
 jump to add review page
 */
- (void)writeReview;
/**
 build tableview footer view
 see more label and write button
 

 @return UIView
 */
- (UIView *)buildFooterView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 build dso info cell

 @param model JobDSOModel
 @return UITableViewCell
 */
- (UITableViewCell*)companyReviewHeaderCell:tableView data:(JobDSOModel*)model;
/**
 build dso reviews cell

 @param model CompanyReviewModel
 @return UITableViewCell
 */
- (UITableViewCell*)companyReviewTableViewCell:tableView data:(CompanyReviewModel*)model;
/**
 UIScrollViewDelegate
 scroll view did scroll
 Handling paged load data
 
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (UIEdgeInsets)edgeInsetsMake;

@end

NS_ASSUME_NONNULL_END
