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


+ (void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel;

+ (void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel onReviewNumChanged:(void(^)(NSInteger reviewNum))onReviewNumChanged;
- (void)viewDidLoad;
- (void)addNavBar;
- (void)dismiss;
- (void)buildViews;
- (UIView*)buildHeader;
- (void)setupRefresh;
- (void)showTopIndicator;
- (void)hideTopIndicator;
- (void)firstRefresh;
- (void)getDatas:(BOOL)isMore;
- (void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore;
- (void)writeReview;
- (void)resetSortAndFilter;
- (void)sortOnClick:(UIView*)view;
- (void)filterOnClick:(UIView*)view;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

NS_ASSUME_NONNULL_END
