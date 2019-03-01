//
//  CommonConfig.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/************************* 下载 *************************/
NSString * const DentistDownloadProgressNotification = @"DentistDownloadProgressNotification";
NSString * const DentistDownloadStateChangeNotification = @"DentistDownloadStateChangeNotification";
NSString * const DentistDownloadMaxConcurrentCountKey = @"DentistDownloadMaxConcurrentCountKey";
NSString * const DentistDownloadMaxConcurrentCountChangeNotification = @"DentistDownloadMaxConcurrentCountChangeNotification";
NSString * const DentistDownloadAllowsCellularAccessKey = @"DentistDownloadAllowsCellularAccessKey";
NSString * const DentistDownloadAllowsCellularAccessChangeNotification = @"DentistDownloadAllowsCellularAccessChangeNotification";

NSString * const DentistUniteDownloadStateChangeNotification = @"DentistUniteDownloadStateChangeNotification";
NSString * const DentistUniteArchiveChangeNotification = @"DentistUniteArchiveChangeNotification";

/************************* 网络 *************************/
NSString * const DentistNetworkingReachabilityDidChangeNotification = @"DentistNetworkingReachabilityDidChangeNotification";
