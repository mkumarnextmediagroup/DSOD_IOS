//
//  DentistDataBaseManager.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const DentistDownloadStateChangeNotification;

extern NSString * const DentistUniteDownloadStateChangeNotification;

NS_ASSUME_NONNULL_BEGIN

@class CMSModel;
@class DetailModel;
@class IdName;
@class MagazineModel;
@interface DentistDataBaseManager : NSObject
+ (instancetype)shareManager;
-(void)queryDetailCmsCaches:(NSString *)articleid completed:(void(^)(DetailModel *model))completed;
-(void)queryCMSCachesList:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;
-(void)queryCMSCachesList:(NSString *)categoryId contentTypeId:(NSString *)contentTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;
// 插入数据
- (void)insertCMSModel:(CMSModel *)cmsmodel completed:(void(^)(BOOL result))completed;
// 插入数据
- (void)insertCMS:(NSString *)articleid jsontext:(NSString *)jsontext completed:(void(^)(BOOL result))completed;
// 更新数据
- (void)updateCMS:(NSString *)articleid jsontext:(NSString *)jsontext completed:(void(^)(BOOL result))completed;
// 更新数据
- (void)deleteCMS:(NSString *)articleid completed:(void(^)(BOOL result))completed;
-(void)CheckIsDowned:(CMSModel *)model completed:(void(^)(NSInteger isdown))completed;
#pragma mark -------缓存接口返回数据
//MARK: 更新数据缓存记录
-(void)updateContentCaches:(NSString *)key jsontext:(NSString *)jsontext completed:(void (^)(BOOL result))completed;
//MARK: 获取媒体列表缓存数据
-(void)queryAllContentsCaches:(NSString *)key completed:(void (^)(NSArray<CMSModel *> *array))completed;
-(void)queryContentsCaches:(NSString *)key completed:(void (^)(NSArray *array))completed;
-(void)queryContentTypesCaches:(void(^)(NSArray<IdName *> *array))completed;
-(void)queryCategoryTypesCaches:(void(^)(NSArray<IdName *> *array))completed;
//MARK:添加杂志记录
- (void)insertUniteModel:(MagazineModel *)model completed:(void(^)(BOOL result))completed;
//unite 下载
-(void)insertUniteArticleArray:(MagazineModel *)model jsonarray:(NSArray *)jsonarray completed:(void(^)(BOOL result))completed;
//MARK:更新杂志下载状态，downstatus==1收藏；0取消收藏
-(void)updateUniteDownstatus:(NSString *)uniteid downstatus:(NSInteger)downstatus completed:(void(^)(BOOL result))completed;
//MARK:archive 删除下载的杂志文章 ，除了已收藏的杂志文章
-(void)archiveUnite:(NSString *)uniteid completed:(void(^)(BOOL result))completed;
//MARK:根据杂志ID查询杂志文章列表
-(void)queryUniteArticlesCachesList:(NSString *)uniteid completed:(void(^)(NSArray<DetailModel *> *array))completed;
//MARK:添加删除杂志文章方法，isbookmark==1收藏；0取消收藏
-(void)updateUniteArticleBookmark:(NSString *)articleid isbookmark:(NSInteger)isbookmark completed:(void(^)(BOOL result))completed;
//MARK:获取已收藏的杂志文章列表
-(void)queryUniteArticlesBookmarkCachesList:(void(^)(NSArray<DetailModel *> *array))completed;
//MARK:根据keyword搜索文章
-(void)queryUniteArticlesCachesByKeywordList:(NSString *)uniteid keywords:(NSString *)keywords completed:(void(^)(NSArray<DetailModel *> *array))completed;
//MARK:检查该杂志是否已经下载
-(void)checkUniteStatus:(NSString *)uniteid  completed:(void(^)(NSInteger result))completed;
@end

NS_ASSUME_NONNULL_END
