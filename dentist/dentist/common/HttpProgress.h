//
// Created by entaoyang on 2018/8/29.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HttpProgress <NSObject>

@optional
- (void)onHttpStart:(int)total;

@optional
- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent;

@optional
- (void)onHttpFinish:(BOOL)success;
@end