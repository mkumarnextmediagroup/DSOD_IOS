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

@property NSString *fullName;
@property(nullable) NSString *phone;

@property BOOL isStudent;
@property BOOL isLinkedin;


@property(nullable) NSString *photo_url;
@property(readonly) NSString *portraitUrlFull;

@property(nullable) IdName *speciality;
@property(nullable) Address *practiceAddress;

@property(nullable) NSMutableArray <Experience, Optional> *experienceArray;
@property(nullable) NSMutableArray <Residency, Optional> *residencyArray;
@property(nullable) NSMutableArray <Education, Optional> *educationArray;
@property(nullable) NSMutableArray <PersonInfo, Optional> *personInfoArray;
@property(nullable) NSMutableArray <UploadData, Optional> *uploadDataArray;

@end
