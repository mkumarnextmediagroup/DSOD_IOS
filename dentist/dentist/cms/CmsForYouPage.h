//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "CMSModel.h"
#import "HttpResult.h"

@interface CmsForYouPage : ListPage<UIScrollViewDelegate>

@property NSMutableArray<NSString *> *segItems;
@property UISegmentedControl *segView;
@property NSString *category;

- (UIView *)makeHeaderView2;
- (UIView *)makeSegPanel;
- (void)onSegValueChanged:(id)sender;
- (void)onClickItem:(NSObject *)item;
- (void)showImageBrowser:(NSInteger)index;
- (void)ArticleMoreActionModel:(CMSModel *)model;
- (void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view;
- (void) handleDeleteBookmark:(HttpResult *)result model:(CMSModel *)model view:(UIView *)view;
- (void) handleAddBookmark:(HttpResult *)result model:(CMSModel *)model view:(UIView *)view;
- (void)ArticleGSKActionModel:(CMSModel *)model;
@end
