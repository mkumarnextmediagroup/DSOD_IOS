//
//  CmsArticleCategoryPage.h
//  dentist
//
//  Created by feng zhenrong on 2018/10/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ListPage.h"
#import "CMSModel.h"
#import "DenActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

@interface CmsArticleCategoryPage : ListPage
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *categoryName;
@property CMSModel *selectModel;

- (void)hideCmsIndicator;
- (void)onBack:(UIButton *)btn;
- (Class)viewClassOfItem:(NSObject *)item;
- (CGFloat)heightOfItem:(NSObject *)item;
- (void)onBindItem:(NSObject *)item view:(UIView *)view;
- (void)onClickItem:(NSObject *)item;
-(void)refreshData;
-(void)ArticleMoreActionModel:(CMSModel *)model;
-(void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view;
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
-(void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(NSString *)categoryName;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
