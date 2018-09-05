//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (myextend)

- (void)tabItem:(NSString *)title imageName:(NSString *)imageName;

- (void)alertOK:(NSString *)title msg:(NSString *)msg okText:(NSString *)okText onOK:(void (^ __nullable)(void))onOK;

- (void)alertConfirm:(NSString *)title msg:(NSString *)msg;
@end