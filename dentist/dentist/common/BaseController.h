//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface BaseController : UIViewController <UITextFieldDelegate>


- (void)openPage:(UIViewController *)c;

- (void)dismiss;

- (void)onTextFieldDone:(UITextField *)textField;

- (void)setTopTitle:(NSString *)title imageName:(UIImage *)imageName;
@end
