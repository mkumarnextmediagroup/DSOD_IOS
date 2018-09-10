//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DatePickerPage : UIViewController

@property UIDatePickerMode datePickerMode;
@property NSDate *date;

@property void (^dateCallback)(NSDate *date);

@end