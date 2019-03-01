//
//  SponsoredCourseViewController.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/20.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SponsoredCourseViewController : UIViewController
@property (nonatomic,strong) NSString *sponsorId;

- (void)viewDidLoad;
- (UIView *)makeHeaderView;
- (void)searchClick;
- (void)back;
- (void)refreshData;
- (void)setupRefresh;
- (void)refreshClick:(UIRefreshControl *)refreshControl;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
