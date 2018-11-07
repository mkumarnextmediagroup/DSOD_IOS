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
@interface DentistDataBaseManager : NSObject
+ (instancetype)shareManager;
-(void)queryCMSCachesList:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed;
// 插入数据
- (void)insertCMSModel:(CMSModel *)cmsmodel completed:(void(^)(BOOL result))completed;
// 插入数据
- (void)insertCMS:(NSString *)articleid jsontext:(NSString *)jsontext completed:(void(^)(BOOL result))completed;
// 更新数据
- (void)updateCMS:(NSString *)articleid jsontext:(NSString *)jsontext completed:(void(^)(BOOL result))completed;
// 更新数据
- (void)deleteCMS:(NSString *)articleid completed:(void(^)(BOOL result))completed;
@end

NS_ASSUME_NONNULL_END
