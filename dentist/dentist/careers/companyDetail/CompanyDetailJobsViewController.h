//
//  CompanyDetailJobsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@protocol CompanyDetailJobsViewDelegate <NSObject>
@optional
- (void)CompanyDetailJobsViewDidSelectAction:(NSString *)jobId;

@end

@interface CompanyDetailJobsViewController : UIViewController

@property (nonatomic,strong) NSString *companyId;
@property (nonatomic,weak) id<CompanyDetailJobsViewDelegate>delegate;



// 是否可以滑动
//Is it currently possible to scroll
@property (nonatomic, assign) BOOL isCanScroll;
// 不滑动事件
// Callback function when scrolling is not possible
@property (nonatomic, copy) void(^noScrollAction)(void) ;

/**
 滚动到初始位置
 Scroll to the initial position
 */
- (void)contentOffsetToPointZero;
/**
 Refresh table data
 */
- (void)reloadData;
/**
 view did load
 call buildview function
 */
- (void)viewDidLoad;
/**
 set dso id
 get all jobs of dso
 
 @param companyId dso id
 */
- (void)setCompanyId:(NSString *)companyId;
/**
 build views
 */
- (void)buildView;
/**
 初始化没有数据时的默认布局
 Initialize the default layout when there is no data
 */
- (void)createEmptyNotice;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
/**
 设置标题，显示职位数量
 Set the title to show the number of jobs
 
 @param jobcount <#jobcount description#>
 */
- (void)setJobCountTitle:(NSInteger)jobcount;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 UIScrollViewDelegate
 scroll view did scroll
 Handling paged load data
 
 @param scrollView UIScrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
