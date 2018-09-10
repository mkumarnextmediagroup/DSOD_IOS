//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Experience;

@interface Experience : JSONModel


//Owner Dentist / Associate Dentist
@property(nullable) NSString <Optional> *praticeType;
@property(nullable) NSString <Optional> *roleAtPratice;
@property(nullable) NSString <Optional> *dentalName;
@property(nullable) NSString <Optional> *practiceName;
@property(nullable) NSString <Optional> *dateFrom;
@property(nullable) NSString <Optional> *dateTo;

@property NSInteger fromMonth;
@property NSInteger fromYear;
@property NSInteger toMonth;
@property NSInteger toYear;


@property BOOL workInThisRole;


- (BOOL)isOwnerDentist;
@end