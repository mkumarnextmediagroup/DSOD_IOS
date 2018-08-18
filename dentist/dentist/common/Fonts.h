//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Fonts : NSObject

@property(class, nonatomic, readonly) UIFont *title;
@property(class, nonatomic, readonly) UIFont *heading1;
@property(class, nonatomic, readonly) UIFont *heading2;
@property(class, nonatomic, readonly) UIFont *body;
@property(class, nonatomic, readonly) UIFont *caption;
@property(class, nonatomic, readonly) UIFont *tiny;

+ (UIFont *)heavy:(int)size;

+ (UIFont *)bold:(int)size;

+ (UIFont *)semiBold:(int)size;

+ (UIFont *)medium:(int)size;

+ (UIFont *)regular:(int)size;
+ (UIFont *)light:(int)size;


@end