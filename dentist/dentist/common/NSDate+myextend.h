//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (myextend)

- (NSInteger)year;

- (NSInteger)month;
- (NSInteger)day;

@end


extern long buildDateLong(NSInteger year, NSInteger month, NSInteger day);