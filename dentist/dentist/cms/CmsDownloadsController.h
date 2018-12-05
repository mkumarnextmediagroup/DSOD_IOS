//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "CMSModel.h"
#import "DenActionSheet.h"


@interface CmsDownloadsController : ListPage

@property NSString *categoryId;
@property CGFloat rowheight;

- (void)downLoadStateChange:(NSNotification *)notification;
- (void)updateFilterView;
- (Class)viewClassOfItem:(NSObject *)item;
- (CGFloat)heightOfItem:(NSObject *)item;
- (void)onBindItem:(NSObject *)item view:(UIView *)view;
- (void)ArticleMoreActionModel:(CMSModel *)model;
- (void)onClickItem:(NSObject *)item;
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
- (void)handleDeleteCMS: (BOOL) result;
- (void)clickFilter:(UIButton *)sender;
@end
