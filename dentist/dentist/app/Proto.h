//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UserInfo.h"

@class HttpResult;
@class IdName;
@class StateCity;


@interface Proto : NSObject


@property(class, readonly) BOOL isLogined;

@property(class, readonly) NSString *lastAccount;
@property(class, readonly) NSString *lastToken;

+ (HttpResult *)resetPwd:(NSString *)email pwd:(NSString *)pwd code:(NSString *)code;

+ (HttpResult *)sendEmailCode:(NSString *)email;

+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name student:(BOOL)student;

+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd;

//LinkedIn request
+ (HttpResult *)sendLinkedInInfo:(NSString *)access_token;

+ (void)linkedinLogin:(NSString *)token userid:(NSString *)userid;

+ (void)logout;

+ (UserInfo *)userInfo:(nonnull NSString *)email;


+ (UserInfo *_Nullable)lastUserInfo;




+ (NSArray *_Nullable)listStates;

+ (NSArray *_Nullable)shortStates;


+ (NSDictionary *_Nullable)getProfileInfo;

+ (BOOL)saveProfileInfo:(NSDictionary *)dic;

+ (NSArray *_Nullable)listArticle;

+ (nullable StateCity *)getStateAndCity:(NSString *)zipCode;

+ (NSMutableArray <IdName *> *)queryDentalSchool;

+ (NSArray<IdName *> *)queryPracticeDSO:(NSString *)name;

+ (NSArray<IdName *> *)queryPracticeRoles:(NSString *)name;

+ (NSArray<IdName *> *)queryPracticeTypes;

+ (NSString *)uploadHeaderImage:(NSString *)localFilePath;

+ (NSMutableArray <IdName *> *)querySpecialty;

@end
