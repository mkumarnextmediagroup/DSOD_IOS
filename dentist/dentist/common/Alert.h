//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertCallback)(void);

@interface Alert : NSObject


@property(nullable) NSString *title;
@property NSString *msg;
@property(nullable) NSString *okText;

//@property(nullable) AlertCallback onDismiss;
@property(nullable) AlertCallback onOK;

- (void)show:(UIViewController *)c;

@end