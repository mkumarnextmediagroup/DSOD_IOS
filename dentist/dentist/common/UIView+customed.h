//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (customed)


- (NSArray *)makeLayout:(void (^)(MASConstraintMaker *))block;

- (void)layoutFillXOffsetTop:(CGFloat)height offset:(CGFloat)offset;

- (void)layoutFillXOffsetBottom:(CGFloat)height offset:(CGFloat)offset;

- (void)layoutFill;

- (void)layoutCenterXOffsetTop:(CGFloat)width height:(CGFloat)height offset:(CGFloat)offset;

- (void)layoutCenterXOffsetBottom:(CGFloat)width height:(CGFloat)height offset:(CGFloat)offset;

- (void)layoutFillXOffsetCenterY:(CGFloat)height offset:(CGFloat)offset;
@end