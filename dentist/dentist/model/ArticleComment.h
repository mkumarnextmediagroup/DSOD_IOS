//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArticleComment : NSObject

@property NSString *articleId;

@property NSString *authAccount;
@property NSString *authName;
@property NSString *authPortrait;
@property NSString *content;
@property NSString *publishDate;
//0-5
@property NSInteger rate;

@end