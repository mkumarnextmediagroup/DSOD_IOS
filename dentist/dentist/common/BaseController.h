//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface BaseController : UIViewController <UITextFieldDelegate>

@property(assign, nonatomic) BOOL isCloseTheGesture;

- (void)openPage:(UIViewController *)c;

- (void)dismiss;

- (void)onTextFieldDone:(UITextField *)textField;

- (void)setTopTitle:(NSString *)title bgColor:(UIColor *)bgColor imageName:(UIImage *)imageName;

- (void)setTopTitle:(NSString *)title leftImageName:(UIImage *)imageName
     rightImageName:(UIImage *)rightImageName rightTitle:(NSString *)rightTitle;


- (void)tabItem:(NSString *)title imageName:(NSString *)imageName;

- (void)alertOK:(NSString *)title msg:(NSString *)msg okText:(NSString *)okText onOK:(void (^ __nullable)(void)) onOK;

- (void)alertConfirm:(NSString *)title msg:(NSString *)msg;

@end
