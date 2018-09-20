//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Residency;

@interface Residency : NSObject

@property(nullable) NSString *schoolName;
@property(nullable) NSString *schoolId;

@property NSInteger fromMonth;
@property NSInteger fromYear;
@property NSInteger toMonth;
@property NSInteger toYear;


- (NSString *)dateFrom;

- (NSString *)dateTo;

@end