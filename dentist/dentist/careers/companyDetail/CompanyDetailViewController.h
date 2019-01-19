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

+ (void)openBy:(UIViewController*)vc companyId:(NSString*)companyId;
- (void)viewDidLoad;
- (void)loadData;
- (void)addNavBar;
- (void)buildView;
- (UIView*)buildHeader;
- (void)showVideo:(NSString*)videoHtmlString;
- (void)searchClick;
- (void)showLocation;
- (void)setupTableContentVC;
- (UIView*)tableContentView;
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)CompanyDetailJobsViewDidSelectAction:(NSString *)jobId;
@end

NS_ASSUME_NONNULL_END
