//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleItemViewDelegate.h"
@class Article;
@class CMSModel;
@interface ArticleItemView : UIView

@property (strong, nonatomic) UIButton *moreButton;
@property (nonatomic,weak) id<ArticleItemViewDelegate>delegate;
@property (strong, nonatomic) Article *model;
@property (strong, nonatomic) CMSModel *cmsmodel;
-(void) bind:(Article*)item ;
-(void) bindCMS:(CMSModel*)item;
-(void) updateBookmarkStatus:(BOOL)ismark;
-(NSArray *)getSeparatedLinesFromLabel:(UILabel *)label text:(NSString *)text;
-(void)moreAction:(UIButton *)sender;
-(void)markAction:(UIButton *)sender;
-(void)showFilter;
@end
