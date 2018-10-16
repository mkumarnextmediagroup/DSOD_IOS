//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;
@protocol ArticleItemViewDelegate <NSObject>

@optional
- (void)CategoryPickerSelectAction:(NSString *)result;
@end

@interface ArticleItemView : UIView

@property (strong, nonatomic) UIButton *moreButton;
@property (nonatomic,weak) id<ArticleItemViewDelegate>delegate;

-(void) bind:(Article*)item ;

@end
