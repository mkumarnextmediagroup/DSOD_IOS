//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "Education.h"
#import "Experience.h"
#import "Residency.h"
#import "PersonInfo.h"
#import "UploadData.h"

@class IdName;

@interface UserInfo : NSObject

- (void)fromDic:(NSDictionary *)dic;


@property NSString *userId;
@property NSString *email;
@property NSString *emailContact;

@property NSString *fullName;
@property(nullable) NSString *phone;

@property BOOL isStudent;
@property BOOL isLinkedin;


@property(nullable) NSString *photo_url;
@property(readonly) NSString *portraitUrlFull;

@property(nullable) IdName *speciality;
@property(nullable) Address *practiceAddress;

@property(nullable) NSMutableArray *experienceArray;
@property(nullable) NSMutableArray *residencyArray;
@property(nullable) NSMutableArray *educationArray;
@property(nullable) NSMutableArray *personInfoArray;
@property(nullable) NSMutableArray *uploadDataArray;

@end
