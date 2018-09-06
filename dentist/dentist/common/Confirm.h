//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Confirm : NSObject

@property(nullable) NSString *title;
@property NSString *msg;
@property(nullable) NSString *okText;
@property(nullable) NSString *cancelText;


- (void)show:(UIViewController *)c onOK:(void (^)(void))onOK;

@end