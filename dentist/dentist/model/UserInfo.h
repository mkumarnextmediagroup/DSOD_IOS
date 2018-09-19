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

@property NSMutableDictionary *dic;


@property NSString *userId;
@property NSString *email;
@property NSString <Optional> *fullName;
@property(nullable) NSString <Optional> *phone;
@property BOOL isStudent;
@property BOOL isLinkedinUser;

//@property(nullable) NSString <Optional> *portraitId;
@property(nullable) NSString <Optional> *portraitUrl;
@property(readonly) NSString <Optional> *portraitUrlFull;

@property(nullable) IdName <Optional> *speciality;


@property(nullable) Address <Optional> *practiceAddress;
@property(nullable) NSMutableArray <Experience, Optional> *experienceArray;
@property(nullable) NSMutableArray <Residency, Optional> *residencyArray;
@property(nullable) NSMutableArray <Education, Optional> *educationArray;
@property(nullable) NSMutableArray <PersonInfo, Optional> *personInfoArray;
@property(nullable) NSMutableArray <UploadData, Optional> *uploadDataArray;

@end
