//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"


@interface Experience : NSObject


//Owner Dentist / Associate Dentist
@property(nullable) NSString *praticeTypeId;
@property(nullable) NSString *praticeType;

@property(nullable) NSString *roleAtPraticeId;
@property(nullable) NSString *roleAtPratice;

@property(nullable) NSString *dsoId;
@property(nullable) NSString *dsoName;

@property NSInteger fromMonth;
@property NSInteger fromYear;
@property NSInteger toMonth;
@property NSInteger toYear;


@property BOOL workInThisRole;

- (BOOL)isOwnerDentist;

@property (readonly) BOOL useDSO;


- (NSString *_Nullable)dateFrom;

- (NSString *_Nullable)dateTo;
@end
