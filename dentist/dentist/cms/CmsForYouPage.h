//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "CMSModel.h"
#import "HttpResult.h"
#import "DenActionSheet.h"
#import "IdName.h"

@interface CmsForYouPage : ListPage<UIScrollViewDelegate>

@property NSMutableArray<NSString *> *segItems;
@property UISegmentedControl *segView;
@property NSString *category;
@property NSString *contenttype;
@property CMSModel *selectModel;
@property NSMutableArray<IdName *> *segItemsModel;

- (UIView *)makeHeaderView2;
- (void)onClickItem:(NSObject *)item;
- (void)showImageBrowser:(NSInteger)index;
- (void)ArticleMoreActionModel:(CMSModel *)model;
- (void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view;
- (void)handleDeleteBookmark:(HttpResult *)result model:(CMSModel *)model view:(UIView *)view;
- (void)handleAddBookmark:(HttpResult *)result model:(CMSModel *)model view:(UIView *)view;
- (void)ArticleGSKActionModel:(CMSModel *)model;
- (void)clickCloseAd:(id)sender;
- (void)getContentCachesData:(NSInteger)page;
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
- (void)handlePicker:(NSString *)result resultName:(NSString *)resultname;
- (void)loadMore;
@end
