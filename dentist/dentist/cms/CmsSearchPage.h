//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "DenActionSheet.h"
#import "CMSModel.h"
#import "HttpResult.h"

@interface CmsSearchPage : ListPage

@property CMSModel *selectModel;

-(void)refreshData;
- (Class)viewClassOfItem:(NSObject *)item;
- (CGFloat)heightOfItem:(NSObject *)item;
- (void)onBindItem:(NSObject *)item view:(UIView *)view;
- (void)ArticleMoreActionModel:(CMSModel *)model;
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
- (void)onClickItem:(NSObject *)item;
- (void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view;
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)cancelBtnClick:(UIButton *)sender;
- (void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName;
- (void) handleDeleteBookmark:(HttpResult *)result view:(UIView *)view model:(CMSModel *)model;
- (void) handleAddBookmark:(HttpResult *)result view:(UIView *)view model:(CMSModel *)model;
@end
