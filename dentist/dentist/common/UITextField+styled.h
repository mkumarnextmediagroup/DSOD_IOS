//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (styled)

@property NSString *hint;

- (void)textColorWhite;

- (void)textAlignCenter;

- (void)textAlignLeft;

- (void)textAlignRight;

- (void)textColorMain;

- (void)textColorAlternate;

- (void)rounded;

- (void)styleNormal;

- (void)styleActive;

- (void)styleError;

- (void)styleSuccess;

- (void)styleDisabled;

- (void)styleLine:(UIColor *)borderColor;

- (void)styleLineNormal;

- (void)styleLineActive;

- (void)styleLineError;

- (void)styleLineSuccess;

- (void)styleLineDisabled;

- (void)stylePassword;

@end