//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleComment;


@interface Article : NSObject

@property NSInteger id;
//orthodontics, practice managment, ...
@property NSString *type;
@property NSString *title;
@property NSString *content;
//May 14,2018
@property NSString *publishDate;

//author or sponsor account
@property NSString *authAccount;
@property NSString *authName;

//an image resource for list item
@property NSString *resImage;
//image, video, audio
@property NSString *resType;

@property BOOL isSponsor;

@property NSArray<ArticleComment *> *comments;

@end