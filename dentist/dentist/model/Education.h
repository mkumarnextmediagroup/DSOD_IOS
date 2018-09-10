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
@property(nullable) NSString <Optional> *dateFrom;
@property(nullable) NSString <Optional> *dateTo;
@property BOOL attendDentalSchoolInUS;




@end