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
@class Article;

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

+ (HttpResult *)saveProfileInfo:(NSDictionary *_Nullable)dic;

+ (NSArray *_Nullable)listArticle;

+ (NSArray *_Nullable)listBookmark;

+ (nullable StateCity *)getStateAndCity:(NSString *_Nullable)zipCode;

+ (NSMutableArray <IdName *> *_Nullable)queryDentalSchool;

+ (NSArray<IdName *> *_Nullable)queryPracticeDSO:(NSString *_Nullable)name;

+ (NSArray<IdName *> *_Nullable)queryPracticeRoles:(NSString *_Nullable)name;

+ (NSArray<IdName *> *_Nullable)queryPracticeTypes;

+ (NSString *_Nullable)uploadHeaderImage:(NSString *_Nullable)localFilePath;

+ (NSMutableArray <IdName *> *_Nullable)querySpecialty;

//MARK:模拟
+(BOOL)archiveActicleArr;

+ (NSString*)getFilePath:(NSString *)aFileName;
//MARK:保存文章列表
+ (BOOL)saveArticleArr:(NSArray *)articleArr;

//MARK:获取Article列表
+(NSArray *)getArticleList;

//MARK:获取bookmark列表
+(NSArray *)getBookmarksList;

//MARK:获取download列表
+(NSArray *)getDownloadList;

//MARK:检测是否bookmark
+(BOOL)checkIsBookmarkByArticle:(NSInteger)articleid;

//MARK:检测是否添加到下载
+(BOOL)checkIsDownloadByArticle:(NSInteger)articleid;

//MARK:根据id获取文章实体
+(Article *)getArticleById:(NSInteger)articleid;

//MARK:添加bookmark
+(BOOL)addBookmarks:(NSInteger)articleid;

//MARK:删除bookmark
+(BOOL)deleteBookmarks:(NSInteger)articleid;

//MARK:添加download
+(BOOL)addDownload:(NSInteger)articleid;

//MARK:删除download
+(BOOL)deleteDownload:(NSInteger)articleid;

@end
