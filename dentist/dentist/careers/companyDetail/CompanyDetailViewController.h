//
//  CompanyDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyDetailViewController : BaseController

@property (nonatomic,strong) NSString *companyId;

/**
 打开公司详情页面
 open the dso details page
 
 @param vc UIViewController
 @param companyId dso id
 */
+ (void)openBy:(UIViewController*)vc companyId:(NSString*)companyId;
/**
 build views
 add navigationbar
 sutup CompanyDetailDescriptionViewController、CompanyDetailJobsViewController、CompanyDetailReviewsViewController
 get dso information
 */
- (void)viewDidLoad;
/**
 load dso information
 */
- (void)loadData;
/**
 add navigation bar
 */
- (void)addNavBar;
/**
 build views
 */
- (void)buildView;
/**
 build  header view of table view, set datas
 
 @return header view
 */
- (UIView*)buildHeader;
/**
 显示视频、在html代码中找出视频的内容调整格式并且显示
 Display the video, find the content of the video in the html code, adjust the format and display
 
 @param videoHtmlString 视频内容的html代码；Video html code
 */
- (void)showVideo:(NSString*)videoHtmlString;
/**
 搜索按钮点击事件
 Search button click event
 */
- (void)searchClick;
/**
 打开地图界面并在地图中显示职位位置
 Open the map page and display the position in the map
 */
- (void)showLocation;
/**
 配置表格视图的内容控制器
 Configuring the content controller for the table view
 */
- (void)setupTableContentVC;
/**
 表格内容布局视图
 Table cell view
 
 @return UIView
 */
- (UIView*)tableContentView;
/**
 页签切换时候，控制视图显示和隐藏
 Control view display and hide when tabs are switched
 
 @param index Currently selected index
 */
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
/**
 CompanyDetailJobsViewDelegate
 job cell click event
 
 @param jobId job id
 */
- (void)CompanyDetailJobsViewDidSelectAction:(NSString *)jobId;
@end

NS_ASSUME_NONNULL_END
