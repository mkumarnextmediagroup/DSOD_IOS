//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;


@interface ArticleItemView : UIView

@property (strong, nonatomic) UIButton *moreButton;

-(void) bind:(Article*)item ;

@end
