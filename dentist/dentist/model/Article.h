//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class ArticleComment;
@class DiscussInfo;

@interface Article : NSObject<NSCoding>

@property NSInteger id;
//orthodontics, practice managment, ...
@property NSString *type;
@property NSString *title;
@property NSString *content;
@property NSString *subContent;
//May 14,2018
@property NSString *publishDate;

//GSK
@property NSString *gskString;


//author or sponsor account
@property NSString *authAccount;
@property NSString *authName;
@property NSString *authAdd;

//an image resource for list item
@property NSString *resImage;
//image, video, audio
@property NSString *resType;

@property BOOL isSponsor;
@property BOOL isBookmark;//test
@property BOOL isDownload;//test

@property NSArray<ArticleComment *> *comments;
@property NSArray<DiscussInfo *> *discussInfo;
@property NSString *categoryName;//latest ;videos;articles;

@end
