//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Toast : NSObject


@property NSString *text;
@property CGFloat y;
@property UIFont *font;
@property UIColor *backColor;
@property UIColor *textColor;

@property int timeout;


@end