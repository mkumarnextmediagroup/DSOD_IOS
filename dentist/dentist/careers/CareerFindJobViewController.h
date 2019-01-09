//
//  CareerFindJobViewController.h
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CareerFindJobViewController : UIViewController

- (void)createEmptyNotice;
- (void)backToFirst;
- (void)refreshData;
- (void)setupRefresh;
- (void)refreshClick:(UIRefreshControl *)refreshControl;
- (void)searchClick;
- (void)clickFilter:(UIButton *)sender;
- (void)setJobCountTitle:(NSInteger)jobcount;
- (UIView *)makeHeaderView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)FollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view;
- (void)UnFollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view;
-(void)searchCondition:(NSDictionary *)condition;

@end
