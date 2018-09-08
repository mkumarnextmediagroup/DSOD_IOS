//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Residency;

@interface Residency : JSONModel

@property(nullable) NSString <Optional> *place;
@property(nullable) NSString <Optional> *dateFrom;
@property(nullable) NSString <Optional> *dateTo;

@end