//
//  DetinstDownloadManager.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DentistDataBaseManager.h"
NS_ASSUME_NONNULL_BEGIN

@class CMSModel;
@class MagazineModel;
@interface DetinstDownloadManager : NSObject
@property (nonatomic,strong) NSMutableArray *cancelUniteArray;
+ (instancetype)shareManager;
-(void)startDownLoadCMSModel:(CMSModel *)cmsmodel addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed;
-(void)startDownLoadUniteArticles:(MagazineModel *)model  addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed;

-(void)cancelDownloadUnite:(MagazineModel *)model;
@end

NS_ASSUME_NONNULL_END
