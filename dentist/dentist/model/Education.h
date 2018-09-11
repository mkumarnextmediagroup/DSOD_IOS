//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Education;


@interface Education : JSONModel

@property NSString <Optional> *schoolName;
@property NSString <Optional> *certificate;
@property BOOL schoolInUS;

@property NSInteger fromMonth;
@property NSInteger fromYear;
@property NSInteger toMonth;
@property NSInteger toYear;


- (NSString *)dateFrom;

- (NSString *)dateTo;


@end