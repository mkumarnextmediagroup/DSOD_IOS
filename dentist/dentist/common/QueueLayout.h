//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QueueLayout : NSObject


@property CGFloat edgeLeft;
@property CGFloat edgeRight;

- (void)add:(UIView *)view height:(CGFloat)height marginTop:(CGFloat)marginTop;

- (void)install;


@end