//
//  CMSDetailViewController.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"
#import "Article.h"
#import "DetailModel.h"
#import "CMSModel.h"
#import "DenActionSheet.h"

@interface CMSDetailViewController : ScrollPage

@property DetailModel *articleInfo;
@property NSString *contentId;

@property (nonatomic,assign) int modelIndexOfArray;
@property (nonatomic,copy) NSArray *cmsmodelsArray;
@property (nonatomic,assign) BOOL goBackCloseAll;
@property (nonatomic,assign) BOOL hideChangePage;

- (UIView *)headerView;
- (void)goToViewAllPage;
- (UIView *)footerView;
- (void)onBack:(UIButton *)btn;
- (void)buildViews;
- (void)moreBtnClick:(UIButton *)btn;
- (void)markBtnClick:(UIButton *)btn;
- (void)gotoReview;
- (void)gskBtnClick;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)showTipView:(NSString *)msg;
- (void)openNewCmsDetail:(NSString*)contentId index:(int)index withAnimation:(CATransitionSubtype)subtype;
- (void)onClickUp:(UIButton *)btn;
- (void)onClickDown:(UIButton *)btn;
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;

@end
