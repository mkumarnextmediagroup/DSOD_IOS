//
//  SliderListView.h
//  dentist
//
//  Created by Jacksun on 2018/11/7.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SliderListViewDelegate <NSObject>

@optional
- (void)gotoDetailPage:(NSString *)articleID;
@end


@interface SliderListView : UIView

/*
 * isSearch:YES is search page, NO is list Page
 * magazineId
 */
@property (nonatomic,copy) NSString *issueNumber;
@property (nonatomic,weak) id<SliderListViewDelegate> delegate;

+ (instancetype)initSliderView:(BOOL)isSearch magazineId:(NSString * _Nullable)magazineId;
+(void)hideSliderView;
- (void)showSliderView;
+(void)attemptDealloc;
- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender;
- (void)initSliderView;
- (void)sortGroupByArr;
- (void)createSearchBar;
- (void)createTableview;
- (UIView *)headerView;
- (void)showFullList;
- (void)createEmptyNotice;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
- (UIView *)subHeaderView;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
