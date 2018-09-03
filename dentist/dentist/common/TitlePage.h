//
// Created by entaoyang@163.com on 2018/9/3.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"


@interface TitlePage : BaseController


//@property NSString* title ;
@property(readonly) UINavigationBar *navBar;


- (UIBarButtonItem *)navBarText:(NSString *)text action:(SEL)action;

- (UIBarButtonItem *)navBarImage:(NSString *)imageName action:(SEL)action;

@end