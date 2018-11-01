//
//  ArticleGSkItemView.h
//  dentist
//
//  Created by feng zhenrong on 2018/10/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleItemViewDelegate.h"
@class Article;
@class CMSModel;
NS_ASSUME_NONNULL_BEGIN

@interface ArticleGSkItemView : UIView
@property (strong, nonatomic) UIButton *moreButton;
@property (nonatomic,weak) id<ArticleItemViewDelegate>delegate;
@property (strong, nonatomic) Article *model;
@property (strong, nonatomic) CMSModel *cmsmodel;
-(void) bind:(Article*)item ;
-(void) bindCMS:(CMSModel*)item;
-(void) updateBookmarkStatus:(BOOL)ismark;
@end

NS_ASSUME_NONNULL_END
