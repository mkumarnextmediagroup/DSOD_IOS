//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MagazineModel.h"

@interface UnitePage : BaseController

- (void)addNotification;
- (void)downLoadStateChange:(NSNotification *)notification;
- (void)archiveChange:(NSNotification *)notification;
- (void)setupNavigation;
- (void)enterTeamCard:(MagazineModel *)model;
- (void)enterUniteDownloading:(MagazineModel*) model;
- (void)setupRefresh;
- (void)showTopIndicator;
- (void)hideTopIndicator;
- (void)firstRefresh;
- (void)getDatas:(BOOL)isMore;
- (void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore;
- (void)gotoThumView:(NSInteger)row;
- (void)openMenu;
- (void)showDownloaded;
- (void)showAllIssues;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)thumDidSelectMenu:(NSInteger)index;
@end
