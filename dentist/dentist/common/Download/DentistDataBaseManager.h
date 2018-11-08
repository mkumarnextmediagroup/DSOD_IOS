//
//  DentistDataBaseManager.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CMSModel;
@class DetailModel;
@class IdName;
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
@end

NS_ASSUME_NONNULL_END
