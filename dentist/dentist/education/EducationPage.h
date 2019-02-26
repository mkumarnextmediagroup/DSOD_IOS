//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"


@interface EducationPage : BaseController

- (void)viewDidLoad;
- (UIView *)makeHeaderView;
-(void)goCategoryPage;
-(void)goSponsoredCoursePage:(NSString *)sponsorId;
-(void)seemoreAction:(UIButton *)sender;
-(void)refreshData;
- (void)setupRefresh;
- (void)refreshClick:(UIRefreshControl *)refreshControl;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)didDentistSelectItemAtIndex:(NSInteger)index;
-(void)didYCMenuSelectItemAtIndex:(NSInteger)index;
-(void)sponsoredAction:(NSIndexPath *)indexPath;
@end
