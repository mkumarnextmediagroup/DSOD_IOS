//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"


@interface Education : NSObject

@property NSString *schoolId;
@property NSString *schoolName;
@property NSString *certificate;
@property BOOL schoolInUS;

@property NSInteger fromMonth;
@property NSInteger fromYear;
@property NSInteger toMonth;
@property NSInteger toYear;


- (NSString *)dateFrom;

- (NSString *)dateTo;


@end