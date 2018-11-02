//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UserInfo.h"
#import "CMSModel.h"
#import "DetailModel.h"
#import "DiscussInfo.h"
#import "BookmarkModel.h"

@class HttpResult;
@class IdName;
@class StateCity;
@class Article;
@class BookmarkModel;

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

+ (DetailModel *)queryForDetailPage:(NSString *)contentId;

//get search result
+ (NSArray<CMSModel *> *)querySearchResults:(NSString *)serachValue pageNumber:(NSInteger)pageNumber;

//MARK:查询媒体列表（CMS_001_01\CMS_001_10）
/**
 @param email 邮箱  是否必须:N
 @param contentTypeId 文章类型ID  是否必须:N
 @param categoryId 分类ID  是否必须:N
 @param sponserId 赞助商ID  是否必须:N
 @param authorId 作者ID  是否必须:N
 @param pageNumber 分页数  是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContents:(NSString *_Nullable)email contentTypeId:(NSString *_Nullable)contentTypeId categoryId:(NSString *_Nullable)categoryId sponserId:(NSString *_Nullable)sponserId pageNumber:(NSInteger)pageNumber authorId:(NSString *_Nullable)authorId;
+ (void)queryAllContents:(NSString *_Nullable)email contentTypeId:(NSString *_Nullable)contentTypeId categoryId:(NSString *_Nullable)categoryId sponserId:(NSString *_Nullable)sponserId pageNumber:(NSInteger)pageNumber authorId:(NSString *_Nullable)authorId completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:根据内容分类查询媒体列表（CMS_001_01\CMS_001_10）
/**
 @param categoryTypeId 文章分类ID 是否必须:N
 @param pageNumber 分页数 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsByCategoryType:(NSString *_Nullable)categoryTypeId pageNumber:(NSInteger)pageNumber;
+ (void)queryAllContentsByCategoryType:(NSString *_Nullable)categoryTypeId pageNumber:(NSInteger)pageNumber completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:根据内容分类查询媒体列表（CMS_001_01\CMS_001_10）
/**
 @param contentTypeId 文章类型ID 是否必须:N
 @param pageNumber 分页数 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsByContentType:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber;
+ (void)queryAllContentsByContentType:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:根据赞助商跟内容分类查询媒体列表（CMS_001_01\CMS_001_10）
/**
  @param sponsorId 赞助商ID 是否必须:N
 @param contentTypeId 文章类型ID 是否必须:N
 @param pageNumber 分页数 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsBySponsorAndContentType:(NSString *_Nullable)sponsorId contentTypeId:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber;
+ (void)queryAllContentsBySponsorAndContentType:(NSString *_Nullable)sponsorId contentTypeId:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:查询媒体详情（CMS_002_01/CMS_002_02）
/**
 @param contentId ID 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryOneContentsByConentId:(NSString *_Nullable)contentId;

//MARK:查询Category（CMS_001_15
+ (NSArray<IdName *> *_Nullable)queryCategoryTypes;
+ (void)queryCategoryTypes:(void(^)(NSArray<IdName *> *array))completed;
//MARK:查询Content Type（CMS_004_03）
+ (NSArray<IdName *> *_Nullable)queryContentTypes;
+ (void)queryContentTypes:(void(^)(NSArray<IdName *> *array))completed;

//MARK:添加评论（CMS_002_06）
/**
 @param email 邮箱 是否必须:Y
 @param contentId 所评论文章ID 是否必须:Y
 @param commentText 评论内容 是否必须:Y
 @param commentRating 评论评分 是否必须:Y
 @return HttpResult
 **/
+(HttpResult*)addComment:(NSString *_Nullable)email contentId:(NSString * _Nullable)contentId commentText:(NSString *_Nullable)commentText commentRating:(NSString *_Nullable)commentRating;

//MARK:查询整个文章的评论（CMS_003_04）
/**
 @param contentId ID 是否必须:Y
 @return 返回DiscussInfo的实体数组
 **/
+ (NSArray<DiscussInfo *> *)queryAllCommentByConent:(NSString *_Nullable)contentId skip:(NSInteger)skip;

//MARK:查询收藏列表
/**
 @param email 邮箱 是否必须:Y
 @param categoryId 类别ID 是否必须:N
 @param contentTypeId 内容分类ID 是否必须:N
 @param pageNumber 分页数 是否必须:Y
 @return 返回CMSModelComment的实体数组
 **/
+ (NSArray<BookmarkModel *> *)queryBookmarksByEmail:(NSString *_Nullable)email categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber;
+ (void)queryBookmarksByEmail:(NSString *_Nullable)email categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId pageNumber:(NSInteger)pageNumber  skip:(NSInteger)skip completed:(void(^)(NSArray<BookmarkModel *> *array))completed;

//MARK:删除收藏
/**
 @param bookmarkid 收藏ID 是否必须:Y
 @return yes/no
 **/
+(BOOL)deleteBookmark:(NSString *_Nullable)bookmarkid;
+(void)deleteBookmark:(NSString *)bookmarkid completed:(void(^)(BOOL result))completed;
//MARK:删除收藏
/**
 @param email 账号 是否必须:Y
 @param contentId 文章ID 是否必须:Y
 @return yes/no
 **/
+(BOOL)deleteBookmarkByEmailAndContentId:(NSString *)email contentId:(NSString *)contentId;
+(void)deleteBookmarkByEmailAndContentId:(NSString *)email contentId:(NSString *)contentId completed:(void(^)(BOOL result))completed;

//MARK:添加收藏
/**
 @param email 邮箱 是否必须:Y
 @param postId  是否必须:Y
 @param title 文章标题 是否必须:Y
 @param url 请求url 是否必须:Y
 @return yes/no
 **/
+(BOOL)addBookmark:(NSString *_Nullable)email postId:(NSString *_Nullable)postId title:(NSString *_Nullable)title url:(NSString *_Nullable)url categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId;
+(void)addBookmark:(NSString *)email postId:(NSString *_Nullable)postId title:(NSString *_Nullable)title url:(NSString *_Nullable)url categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId completed:(void(^)(BOOL result))completed;

//MARK:获取单个文件（ADMIN PORTAL Only）
+(NSString *)getFileUrlByObjectId:(NSString *_Nullable)objectid;

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

//MARK:查询杂志列表集合
+(NSArray*)findAllMagazines:(NSInteger)skip;

//MARK:get the unite detail 
+ (DetailModel *)queryForUniteDetailInfo:(NSString *)contentId;

@end
