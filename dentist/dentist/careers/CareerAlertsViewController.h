//
//  CareerAlertsViewController.h
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobAlertsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CareerAlertsViewController : UIViewController

-(void)setNavigationItem;
-(void)addClick;
-(void)refreshData;
//MARK: 下拉刷新
- (void)setupRefresh;
//MARK: 下拉刷新触发,在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl;
- (void)createEmptyNotice;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; // 77
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)configSwipeButtons;
- (void)configDeleteButton:(UIButton*)deleteButton;
- (void)deleteAction:(UIButton *)sender;
- (void)JobAlertsEditAction:(JobAlertsModel *)model;
- (void)JobAlertsAction:(JobAlertsModel *)model;
@end

NS_ASSUME_NONNULL_END
