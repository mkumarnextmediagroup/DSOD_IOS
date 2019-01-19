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

/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) void(^noScrollAction)(void) ;

- (void)contentOffsetToPointZero;
- (void)viewDidLoad;
- (void)setJobDSOModel:(JobDSOModel *)jobDSOModel;
- (void)reloadComment;
- (void)getNewJobDSOModel;
- (void)seeMore;
- (void)writeReview;
- (UIView *)buildFooterView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell*)companyReviewHeaderCell:tableView data:(JobDSOModel*)model;
- (UITableViewCell*)companyReviewTableViewCell:tableView data:(CompanyReviewModel*)model;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (UIEdgeInsets)edgeInsetsMake;

@end

NS_ASSUME_NONNULL_END
