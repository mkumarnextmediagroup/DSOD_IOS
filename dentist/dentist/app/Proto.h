//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UserInfo.h"

@class HttpResult;


@interface Proto : NSObject


@property(class) BOOL isLogined;

@property(class) NSString *lastAccount;
@property(class) NSString *lastToken;

+ (HttpResult *)resetPwd:(NSString *)email pwd:(NSString *)pwd code:(NSString *)code;

+ (HttpResult *)sendEmailCode:(NSString *)email;

+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name student:(BOOL)student;

+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd;

//LinkedIn request
+ (HttpResult *)sendLinkedInInfo:(NSString *)access_token;

+ (void)logout;

+ (UserInfo *)userInfo:(nonnull NSString *)email;

+ (UserInfo *)addExperience:(nonnull NSString *)email exp:(Experience *)exp;

+ (UserInfo *)saveExperience:(nonnull NSString *)email index:(int)index exp:(Experience *)exp;

+ (UserInfo *)addResidency:(nonnull NSString *)email residency:(Residency *)residency;

+ (UserInfo *)saveResidency:(nonnull NSString *)email index:(int)index residency:(Residency *)residency;

+ (UserInfo *)addEducation:(nonnull NSString *)email edu:(Education *)edu;

+ (UserInfo *)saveEducation:(nonnull NSString *)email index:(int)index edu:(Education *)edu;

+ (UserInfo *)savePractice:(nonnull NSString *)email address:(Address *)address;

+ (UserInfo *)lastUserInfo;

+ (NSArray *)listSpeciality;

+ (NSArray *)listPracticeType;

+ (NSArray *)listRoleAtPractice;

+ (NSArray *)listDentalNames;
@end
