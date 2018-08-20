//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StackLayout : NSObject


@property CGFloat edge;

- (void)push:(UIView *)view height:(CGFloat)height marginBottom:(CGFloat)marginBottom;

- (void)install;


@end