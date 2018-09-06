//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "Education.h"
#import "Experience.h"
#import "Residency.h"


@interface UserInfo : NSObject

@property(nonnull) NSString *email;
@property(nonnull) NSString *fullName;
@property(nullable) NSString *phone;

@property(nullable) NSString *portraitId;
@property(nullable) NSString *portraitUrl;

@property(nullable) NSString *specialityId;
@property(nullable) NSString *specialityLabel;


@property(nullable) Address *practiceAddress;
@property(nullable) NSArray<__kindof Experience *> *experienceArray;
@property(nullable) NSArray<__kindof Residency *> *residencyArray;
@property(nullable) NSArray<__kindof Education *> *educationArray;

@end