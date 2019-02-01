//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IdName;

@interface UIViewController (myextend)

@property(readonly) UINavigationBar *navBar;

- (void)tabItem:(nonnull NSString *)title imageName:(nonnull NSString *)imageName;
- (void)tabItem:(nonnull NSString *)title imageName:(nonnull NSString *)imageName tag:(NSInteger)tag;

- (void)alertOK:(nullable NSString *)title msg:(nonnull NSString *)msg okText:(nullable NSString *)okText onOK:(void (^ __nullable)(void))onOK;

- (void)alertMsg:(nonnull NSString *)msg onOK:(void (^ __nullable)(void))onOK;

- (UIBarButtonItem *)navBarBack:(nullable id)target action:(SEL)action;

- (UIBarButtonItem *)navBarText:(NSString *)text target:(nullable id)target action:(SEL)action;
- (UIBarButtonItem *)navBarText:(NSString *)text textFont:(UIFont *)textFont target:(nullable id)target action:(SEL)action;

- (UIBarButtonItem *)navBarImage:(NSString *)imageName target:(nullable id)target action:(SEL)action;
- (UIBarButtonItem *)navBarImageBtn:(UIImage *)imagebtn target:(nullable id)target action:(SEL)action;

- (UIBarButtonItem *)backBarButtonClose;

- (void)openPage:(UIViewController *)page;

- (void)pushPage:(UIViewController *)page;

- (void)popPage;

- (void)dismiss;

- (void)closeKeyboardWhenClickSelfView;


- (void)showLoading;
    
- (void)hideLoading;

- (void)showIndicator;

- (void)hideIndicator;
- (void)hideIndicator:(NSTimeInterval)delay;


- (void)selectIdName:(NSString *)title array:(NSArray<IdName *> *)array selectedId:(NSString *)selectedId result:(void (^)(IdName *))result;

@end
