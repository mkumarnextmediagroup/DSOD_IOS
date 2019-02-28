//
//  DentistNetworkReachabilityManager.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface DentistNetworkReachabilityManager : NSObject
// 当前网络状态
@property (nonatomic, assign, readonly) AFNetworkReachabilityStatus networkReachabilityStatus;

// 获取单例
+ (instancetype)shareManager;

// 监听网络状态
- (void)monitorNetworkStatus;

@end
