//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (myextend)

@property(readonly) UINavigationBar *navBar;

- (void)tabItem:(nonnull NSString *)title imageName:(nonnull NSString *)imageName;

- (void)alertOK:(nullable NSString *)title msg:(nonnull NSString *)msg okText:(nullable NSString *)okText onOK:(void (^ __nullable)(void))onOK;

- (void)alertMsg:(nonnull NSString *)msg onOK:(void (^ __nullable)(void))onOK;

- (UIBarButtonItem *)navBarBack:(nullable id)target action:(SEL)action;

- (UIBarButtonItem *)navBarText:(NSString *)text target:(nullable id)target action:(SEL)action;

- (UIBarButtonItem *)navBarImage:(NSString *)imageName target:(nullable id)target action:(SEL)action;

- (UIBarButtonItem *)backBarButtonClose;

- (void)openPage:(UIViewController *)page;

- (void)pushPage:(UIViewController *)page;

- (void)popPage;

- (void)dismiss;

- (void)closeKeyboardWhenClickSelfView;

- (void)showIndicator;

- (void)hideIndicator;

@end