//
//  CommonConfig.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//
#import <UIKit/UIKit.h>
/************************* 下载 *************************/
extern NSString * const DentistDownloadProgressNotification;                   // 进度回调通知
extern NSString * const DentistDownloadStateChangeNotification;                // 状态改变通知
extern NSString * const DentistDownloadMaxConcurrentCountKey;                  // 最大同时下载数
extern NSString * const DentistDownloadMaxConcurrentCountChangeNotification;   // 最大同时下载数量改变通知
extern NSString * const DentistDownloadAllowsCellularAccessKey;                // 是否允许蜂窝网络下载key
extern NSString * const DentistDownloadAllowsCellularAccessChangeNotification; // 是否允许蜂窝网络下载改变通知

/************************* uinite下载 *************************/
extern NSString * const DentistUniteDownloadStateChangeNotification;                // uinite状态改变通知
extern NSString * const DentistUniteArchiveChangeNotification;                // uinite archive改变通知

/************************* 网络 *************************/
extern NSString * const DentistNetworkingReachabilityDidChangeNotification;    // 网络改变改变通知
