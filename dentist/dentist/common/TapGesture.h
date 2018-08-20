//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TapGesture : UITapGestureRecognizer

@property (nullable) id target;
@property SEL action;

- (id)initWithTarget:(nullable id)target action:(nullable SEL)action;

@end