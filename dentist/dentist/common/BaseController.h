//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseController : UIViewController <UITextFieldDelegate>


- (void)onTextFieldDone:(UITextField *)textField;

- (void)setTopTitle:(NSString *)title bgColor:(UIColor *)bgColor imageName:(UIImage *)imageName;


@end
