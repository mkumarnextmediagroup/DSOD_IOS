//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UserInfo.h"
#import "CMSModel.h"

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

//get search result
+ (NSArray<CMSModel *> *)querySearchResults:(NSString *)serachValue;

//MARK:查询媒体列表（CMS_001_01\CMS_001_10）
+ (NSArray<CMSModel *> *_Nullable)queryAllContents:(NSString *_Nullable)email contentTypeId:(NSString *_Nullable)contentTypeId categoryId:(NSString *_Nullable)categoryId sponserId:(NSString *_Nullable)sponserId pageNumber:(NSInteger)pageNumber authorId:(NSString *_Nullable)authorId;

//MARK:根据内容分类查询媒体列表（CMS_001_01\CMS_001_10）
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsBycontentType:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber;

//MARK:查询Category（CMS_001_15
+ (NSArray<IdName *> *_Nullable)queryCategoryTypes;
//MARK:查询Content Type（CMS_004_03）
+ (NSArray<IdName *> *_Nullable)queryContentTypes;

//MARK:模拟
+(BOOL)archiveActicleArr;

+ (NSString*_Nullable)getFilePath:(NSString *_Nullable)aFileName;
//MARK:保存文章列表
+ (BOOL)saveArticleArr:(NSArray *_Nullable)articleArr;

//MARK:获取Article列表
+(NSArray *_Nullable)getArticleList;
//MARK:根据author获取Article列表
+(NSArray *)getArticleListByAuthor:(NSString *)author category:(NSString *)category  type:(NSString *)type;
//MARK:根据category获取Article列表
+(NSArray *_Nullable)getArticleListByCategory:(NSString *_Nullable)category;

//MARK:根据type获取Article列表
+(NSArray *_Nullable)getArticleListByType:(NSString *_Nullable)type;

//MARK:根据categoryh跟type获取Article列表
+(NSArray *_Nullable)getArticleListByCategory:(NSString *_Nullable)category type:(NSString *_Nullable)type;

//MARK:根据keywords获取Article列表
+(NSArray *_Nullable)getArticleListByKeywords:(NSString *_Nullable)keywords;


//MARK:根据keywords and type获取Article列表
+(NSArray *_Nullable)getArticleListByKeywords:(NSString *_Nullable)keywords type:(NSString *_Nullable)type;

//MARK:获取bookmark列表
+(NSArray *_Nullable)getBookmarksList;
//MARK:根据Bookmarks跟type获取Article列表
+(NSArray *_Nullable)getBookmarksListByCategory:(NSString *_Nullable)category type:(NSString *_Nullable)type;

//MARK:获取download列表
+(NSArray *_Nullable)getDownloadList;

//MARK:根据DownloadList跟type获取Article列表
+(NSArray *_Nullable)getDownloadListByCategory:(NSString *_Nullable)category type:(NSString *_Nullable)type;

//MARK:检测是否bookmark
+(BOOL)checkIsBookmarkByArticle:(NSInteger)articleid;

//MARK:检测是否添加到下载
+(BOOL)checkIsDownloadByArticle:(NSInteger)articleid;

//MARK:根据id获取文章实体
+(Article *_Nullable)getArticleById:(NSInteger)articleid;

//MARK:添加bookmark
+(BOOL)addBookmarks:(NSInteger)articleid;

//MARK:删除bookmark
+(BOOL)deleteBookmarks:(NSInteger)articleid;

//MARK:添加download
+(BOOL)addDownload:(NSInteger)articleid;

//MARK:删除download
+(BOOL)deleteDownload:(NSInteger)articleid;

@end
