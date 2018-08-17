//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (styled)

- (UITextField *)textColorMain;
- (UITextField *)textColorAlternate;

- (UITextField *)styleRound:(UIColor *)borderColor;

- (UITextField *)styleNormal;

- (UITextField *)styleActive;

- (UITextField *)styleError;

- (UITextField *)styleSuccess;

- (UITextField *)styleDisabled;

- (UITextField *)styleLine:(UIColor *)borderColor;

- (UITextField *)styleLineNormal;

- (UITextField *)styleLineActive;

- (UITextField *)styleLineError;

- (UITextField *)styleLineSuccess;

- (UITextField *)styleLineDisabled;

@end