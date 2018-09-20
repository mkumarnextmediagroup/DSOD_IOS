//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (myextend)

- (NSInteger)year;

- (NSInteger)month;
- (NSInteger)day;

-(NSString*) format:(NSString*) pattern;


+ (NSDate*) dateBy:(NSInteger)year month:(NSInteger) month day:(NSInteger)day;

@end


extern long buildDateLong(NSInteger year, NSInteger month, NSInteger day);