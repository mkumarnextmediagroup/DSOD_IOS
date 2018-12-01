//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "BookmarkModel.h"
#import "HttpResult.h"
#import "CMSModel.h"

@interface CmsBookmarkController : ListPage
@property NSString *categoryId;
@property NSString *contentTypeId;
@property CGFloat rowheight;

-(void)updateFilterView;
- (Class)viewClassOfItem:(NSObject *)item;
- (CGFloat)heightOfItem:(NSObject *)item;
- (void)onBindItem:(NSObject *)item view:(UIView *)view;
- (void)BookMarkActionModel:(BookmarkModel *)model;
- (void)handleDeleteBookmarkWithResult:(HttpResult *)result and:(BookmarkModel *)model;
- (void)onClickItem:(NSObject *)item;
- (void)clickFilter:(UIButton *)sender;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)handleSelectFilterWithCategory:(NSString *) category andType:(NSString *)type;
- (void)handleQueryBookmarks:(NSArray<CMSModel *> *)array;
@end
