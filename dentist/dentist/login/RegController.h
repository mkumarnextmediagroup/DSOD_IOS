//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "BaseController.h"

@interface RegController : BaseController

@property BOOL student;
@property (copy,nonatomic)void(^registSuccessBlock)(void);//申明回调函数

@property (strong, nonatomic)NSString *nameStr;
@property (strong, nonatomic)NSString *emailStr;

@end
