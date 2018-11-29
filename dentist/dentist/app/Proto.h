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
@class MagazineModel;
@class JobModel;
@class JobBookmarkModel;

@interface Proto : NSObject


@property(class, readonly) BOOL isLogined;

@property(class, readonly) NSString *lastAccount;
@property(class, readonly) NSString *lastToken;

+ (NSString *)configUrl:(NSString *)modular;
+ (NSArray *)uniteArticleDesc;

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


+ (UserInfo *_Nullable)getProfileInfo;

+ (HttpResult *)saveProfileInfo:(NSDictionary *_Nullable)dic;

+ (NSArray *_Nullable)listArticle;

+ (NSArray *_Nullable)listBookmark;

+ (nullable StateCity *)getStateAndCity:(NSString *_Nullable)zipCode;

+ (NSMutableArray <IdName *> *_Nullable)queryDentalSchool;

+ (NSArray<IdName *> *_Nullable)queryPracticeDSO:(NSString *_Nullable)name;

+ (NSArray<IdName *> *_Nullable)queryPracticeRoles:(NSString *_Nullable)name;

+ (NSArray<IdName *> *_Nullable)queryPracticeTypes;

+ (NSString *_Nullable)uploadHeaderImage:(NSString *_Nullable)localFilePath;

+ (HttpResult *_Nullable)uploadResume:(NSString *_Nonnull)localFilePath progress:(id<HttpProgress>_Nonnull)httpProgressSend;

+ (NSURL*_Nullable)downloadResume:(NSString *_Nullable)resumeUrl fileName:(NSString*_Nullable)fileName;

+ (NSMutableArray <IdName *> *_Nullable)querySpecialty;

+ (DetailModel *)queryForDetailPage:(NSString *)contentId;
+ (void)queryForDetailPage:(NSString *_Nullable)contentId completed:(void(^)(BOOL result,NSString* jsontext))completed;

//get search result
+ (NSArray<CMSModel *> *)querySearchResults:(NSString *)serachValue skip:(NSInteger)skip;
+ (void)querySearchResults:(NSString *)serachValue skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:查询媒体列表（CMS_001_01\CMS_001_10）
/**
 @param email 邮箱  是否必须:N
 @param contentTypeId 文章类型ID  是否必须:N
 @param categoryId 分类ID  是否必须:N
 @param sponserId 赞助商ID  是否必须:N
 @param authorId 作者ID  是否必须:N
 @param skip 分页数  是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContents:(NSString *_Nullable)email contentTypeId:(NSString *_Nullable)contentTypeId categoryId:(NSString *_Nullable)categoryId sponserId:(NSString *_Nullable)sponserId skip:(NSInteger)skip authorId:(NSString *_Nullable)authorId;
+ (void)queryAllContents:(NSString *_Nullable)email contentTypeId:(NSString *_Nullable)contentTypeId categoryId:(NSString *_Nullable)categoryId sponserId:(NSString *_Nullable)sponserId skip:(NSInteger)skip authorId:(NSString *_Nullable)authorId completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:根据内容分类查询媒体列表（CMS_001_01\CMS_001_10）
/**
 @param categoryTypeId 文章分类ID 是否必须:N
 @param skip 分页数 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsByCategoryType:(NSString *_Nullable)categoryTypeId skip:(NSInteger)skip;
+ (void)queryAllContentsByCategoryType:(NSString *_Nullable)categoryTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;
+ (void)queryAllContentsByCategoryType2:(NSString *_Nullable)categoryTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array,NSString *categoryType))completed;

//MARK:根据内容分类查询媒体列表（CMS_001_01\CMS_001_10）
/**
 @param contentTypeId 文章类型ID 是否必须:N
 @param skip 分页数 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsByContentType:(NSString *_Nullable)contentTypeId skip:(NSInteger)skip;
+ (void)queryAllContentsByContentType:(NSString *_Nullable)contentTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;

//MARK:根据赞助商跟内容分类查询媒体列表（CMS_001_01\CMS_001_10）
/**
  @param sponsorId 赞助商ID 是否必须:N
 @param contentTypeId 文章类型ID 是否必须:N
 @param skip 分页数 是否必须:Y
 @return 返回CMSModel的实体数组
 **/
+ (NSArray<CMSModel *> *_Nullable)queryAllContentsBySponsorAndContentType:(NSString *_Nullable)sponsorId contentTypeId:(NSString *_Nullable)contentTypeId skip:(NSInteger)skip;
+ (void)queryAllContentsBySponsorAndContentType:(NSString *_Nullable)sponsorId contentTypeId:(NSString *_Nullable)contentTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;

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
+(HttpResult*)addComment:(NSString *_Nullable)email contentId:(NSString * _Nullable)contentId commentText:(NSString *_Nullable)commentText commentRating:(NSString *_Nullable)commentRating fullName:(NSString*_Nullable)fullName;

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
 @param skip 分页数 是否必须:Y
 @return 返回CMSModelComment的实体数组
 **/
+ (NSArray<BookmarkModel *> *)queryBookmarksByEmail:(NSString *_Nullable)email categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId skip:(NSInteger)skip;
+ (void)queryBookmarksByEmail:(NSString *_Nullable)email categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<BookmarkModel *> *array))completed;

//MARK:删除收藏
/**
 @param bookmarkid 收藏ID 是否必须:Y
 @return yes/no
 **/
+(BOOL)deleteBookmark:(NSString *_Nullable)bookmarkid;
+(void)deleteBookmark:(BookmarkModel *)model completed:(void(^)(HttpResult *result))completed;
//MARK:删除收藏
/**
 @param email 账号 是否必须:Y
 @param contentId 文章ID 是否必须:Y
 @return yes/no
 **/
+(BOOL)deleteBookmarkByEmailAndContentId:(NSString *)email contentId:(NSString *)contentId;
+(void)deleteBookmarkByEmailAndContentId:(NSString *)email contentId:(NSString *)contentId completed:(void(^)(HttpResult *result))completed;

//MARK:添加收藏
/**
 @param email 邮箱 是否必须:Y
 @param postId  是否必须:Y
 @param title 文章标题 是否必须:Y
 @param url 请求url 是否必须:Y
 @return yes/no
 **/
+(BOOL)addBookmark:(NSString *_Nullable)email postId:(NSString *_Nullable)postId title:(NSString *_Nullable)title url:(NSString *_Nullable)url categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId;
+(void)addBookmark:(NSString *)email postId:(NSString *_Nullable)postId title:(NSString *_Nullable)title url:(NSString *_Nullable)url categoryId:(NSString *_Nullable)categoryId contentTypeId:(NSString *_Nullable)contentTypeId completed:(void(^)(HttpResult * result))completed;
+(void)addBookmark:(NSString *)email cmsmodel:(CMSModel *)model completed:(void(^)(HttpResult *result))completed;

//MARK:获取单个文件（ADMIN PORTAL Only）
+(NSString *)getFileUrlByObjectId:(NSString *_Nullable)objectid;
+(NSString *)getPhotoDownloadByEmail:(NSString *_Nullable)email createtime:(NSString *_Nullable)create_time;
+(NSString *)getPhotoDownloadByEmailUrl:(NSString *_Nullable)emailurl;

//MARK:查询杂志列表集合
+(NSArray*)findAllMagazines:(NSInteger)skip;

//MARK:get the unite detail 
+ (DetailModel *)queryForUniteDetailInfo:(NSString *)contentId;
//MARK:查询杂志详情接口
+ (void)queryMagazinesDetail:(NSString *)magazineId completed:(void(^)(MagazineModel *model))completed;


//获得广告插件里面服务商id
+ (void)getAdbutlerSponsor:(void(^)(NSDictionary*))completed;

//获得重定向后的地址
+ (NSString*)getRedirectUrl:(NSString*)url;

#pragma mark Careers API
//2.1. 查看职位明细接口
+ (void)findJobById:(NSString*)jobId completed:(void(^)(JobModel *_Nullable jobModel))completed ;
//MARK:2.2.    查询所有职位列表
+ (void)queryAllJobs:(NSString *_Nullable)sort categroy:(NSString *_Nullable)categroy salary:(NSString *_Nullable)salary experience:(NSString *_Nullable)experience location:(NSString *_Nullable)location distance:(NSString *_Nullable)distance jobTitle:(NSString *_Nullable)jobTitle company:(NSString *_Nullable)company skip:(NSInteger)skip completed:(void(^)(NSArray<JobModel *> *array,NSInteger totalCount))completed;
//MARK:2.2.    查询所有职位列表
+ (void)queryAllJobs:(NSInteger)skip completed:(void(^)(NSArray<JobModel *> *array,NSInteger totalCount))completed;

//MARK:2.7.   查询已申请职位列表
+ (void)queryAllApplicationJobs:(NSString *_Nullable)sort categroy:(NSString *_Nullable)categroy salary:(NSString *_Nullable)salary experience:(NSString *_Nullable)experience location:(NSString *_Nullable)location distance:(NSString *_Nullable)distance jobTitle:(NSString *_Nullable)jobTitle company:(NSString *_Nullable)company skip:(NSInteger)skip completed:(void(^)(NSArray<JobModel *> *array,NSInteger totalCount))completed;
//MARK:2.7.    查询所有职位列表
+ (void)queryAllApplicationJobs:(NSInteger)skip completed:(void(^)(NSArray<JobModel *> *array,NSInteger totalCount))completed;
//MARK:2.6.    添加职位申请接口
+(void)addJobApplication:(NSString *_Nullable)jobId completed:(void(^)(HttpResult *result))completed;
//MARK:2.8.  添加职位关注接口
+(void)addJobBookmark:(NSString *_Nullable)jobId completed:(void(^)(HttpResult *result))completed;
//MARK:2.9.  删除职位关注接口
+(void)deleteJobBookmark:(NSString *_Nullable)jobId completed:(void(^)(HttpResult *result))completed;
//MARK:2.10.   查询已关注职位列表
+ (void)queryJobBookmarks:(NSString *_Nullable)sort categroy:(NSString *_Nullable)categroy salary:(NSString *_Nullable)salary experience:(NSString *_Nullable)experience location:(NSString *_Nullable)location distance:(NSString *_Nullable)distance jobTitle:(NSString *_Nullable)jobTitle company:(NSString *_Nullable)company skip:(NSInteger)skip completed:(void(^)(NSArray<JobBookmarkModel *> *array))completed;
//MARK:2.10.   查询已关注职位列表
+ (void)queryJobBookmarks:(NSInteger)skip completed:(void(^)(NSArray<JobBookmarkModel *> *array))completed ;
@end
