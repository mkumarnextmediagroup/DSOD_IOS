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

@interface UserInfo : JSONModel

@property(nonnull) NSString *email;
@property(nonnull) NSString <Optional> *fullName;
@property(nullable) NSString <Optional> *phone;
@property BOOL isStudent;
@property BOOL isLinkedinUser;

@property(nullable) NSString <Optional> *portraitId;
@property(nullable) NSString <Optional> *portraitUrl;

@property(nullable) NSString <Optional> *specialityId;
@property(nullable) NSString <Optional> *specialityLabel;


@property(nullable) Address <Optional> *practiceAddress;
@property(nullable) NSMutableArray <Experience, Optional> *experienceArray;
@property(nullable) NSMutableArray <Residency, Optional> *residencyArray;
@property(nullable) NSMutableArray <Education, Optional> *educationArray;
@property(nullable) NSMutableArray <PersonInfo, Optional> *personInfoArray;
@property(nullable) NSMutableArray <UploadData, Optional> *uploadDataArray;

@end
