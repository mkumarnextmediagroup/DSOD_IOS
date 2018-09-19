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

+ (void)linkedinLogin:(NSString *)token userid:(NSString *)userid;

+ (void)logout;

+ (UserInfo *)userInfo:(nonnull NSString *)email;

+ (UserInfo *_Nullable)addExperience:(nonnull NSString *)email exp:(Experience *_Nullable)exp;

+ (UserInfo *_Nullable)saveExperience:(nonnull NSString *)email index:(int)index exp:(Experience *_Nullable)exp;

+ (UserInfo *_Nullable)addResidency:(nonnull NSString *)email residency:(Residency *_Nullable)residency;

+ (UserInfo *_Nullable)saveResidency:(nonnull NSString *)email index:(int)index residency:(Residency *_Nullable)residency;

+ (UserInfo *_Nullable)addEducation:(nonnull NSString *)email edu:(Education *_Nullable)edu;

+ (UserInfo *_Nullable)saveEducation:(nonnull NSString *)email index:(int)index edu:(Education *_Nullable)edu;

+ (UserInfo *_Nullable)savePractice:(nonnull NSString *)email address:(Address *_Nullable)address;

+ (void)saveLastUserInfo:(UserInfo *_Nullable)info;

+ (UserInfo *_Nullable)lastUserInfo;

+ (NSArray *_Nullable)listSpeciality;

+ (NSArray *_Nullable)listPracticeType;

+ (NSArray *_Nullable)listRoleAtPractice;

+ (NSArray *_Nullable)listDentalNames;

+ (NSArray *_Nullable)listStates;

+ (NSArray *_Nullable)shortStates;

+ (NSArray *_Nullable)listResidency;

+ (HttpResult *_Nullable)getProfileInfo;
+ (NSArray *_Nullable)listArticle;

+ (HttpResult *)getStateAndCity;
@end
