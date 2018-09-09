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

@property(nullable) NSString <Optional> *portraitId;
@property(nullable) NSString <Optional> *portraitUrl;

@property(nullable) NSString <Optional> *specialityId;
@property(nullable) NSString <Optional> *specialityLabel;


@property(nullable) Address <Optional> *practiceAddress;
@property(nullable) NSArray <Experience, Optional> *experienceArray;
@property(nullable) NSArray <Residency, Optional> *residencyArray;
@property(nullable) NSArray <Education, Optional> *educationArray;
@property(nullable) NSArray <PersonInfo, Optional> *personInfoArray;
@property(nullable) NSArray <UploadData, Optional> *uploadDataArray;

@end
