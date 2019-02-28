//
//  DentistDownloadManager.h
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
@class DentistDownloadModel;
typedef NS_ENUM(NSInteger, DentistDownloadState) {
    DentistDownloadStateDefault = 0,  // 默认
    DentistDownloadStateDownloading,  // 正在下载
    DentistDownloadStateWaiting,      // 等待
    DentistDownloadStatePaused,       // 暂停
    DentistDownloadStateFinish,       // 完成
    DentistDownloadStateError,        // 错误
};

@interface DentistDownloadManager : NSObject
@property (nonatomic,strong) NSMutableArray *cancelUniteArray;
+ (instancetype)shareManager;

/************************* cms跟unite下载 *************************/
-(void)startDownLoadCMSModel:(CMSModel *)cmsmodel addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed;
-(void)startDownLoadUniteArticles:(MagazineModel *)model  addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed;

-(void)cancelDownloadUnite:(MagazineModel *)model;

/************************* 下载 *************************/
// 开始下载
- (void)startDownloadTask:(DentistDownloadModel *)model;

// 暂停下载
- (void)pauseDownloadTask:(DentistDownloadModel *)model;

// 删除下载任务及本地缓存
- (void)deleteTaskAndCache:(DentistDownloadModel *)model;

// 下载时，杀死进程，更新所有正在下载的任务为等待
- (void)updateDownloadingTaskState;

// 重启时开启等待下载的任务
- (void)openDownloadTask;
@end

NS_ASSUME_NONNULL_END
