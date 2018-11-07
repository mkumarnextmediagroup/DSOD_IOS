//
//  DetinstDownloadManager.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CMSModel;
@interface DetinstDownloadManager : NSObject
+ (instancetype)shareManager;
-(void)startDownLoadCMSModel:(CMSModel *)cmsmodel addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed;
@end

NS_ASSUME_NONNULL_END
