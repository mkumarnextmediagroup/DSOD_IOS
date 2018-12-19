//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "ListPage.h"
#import "CMSModel.h"
#import "DenActionSheet.h"

@interface CmsCategoryPage : ListPage

@property NSString *type;
@property CMSModel *selectModel;

- (Class)viewClassOfItem:(NSObject *)item;
- (CGFloat)heightOfItem:(NSObject *)item;
- (void)onBindItem:(NSObject *)item view:(UIView *)view;
- (void)refreshData;
- (void)ArticleMoreActionModel:(CMSModel *)model;
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
- (void)onClickItem:(NSObject *)item;
- (void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName;
- (void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void) handleTextFieldBlock: (UITextField *) textField;
@end
