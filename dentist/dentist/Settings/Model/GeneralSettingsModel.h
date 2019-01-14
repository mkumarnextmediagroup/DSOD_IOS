//
//  GeneralSettingsModel.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/14.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GeneralSettingsModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*userId;
@property BOOL useFaceID;
@property BOOL useDsoDentistOffline;
@property NSString <Optional>*playbackSpeed;
@property NSString <Optional>*videoDownloadQuality;
@property BOOL downloadOnlyWiFi;
@end

NS_ASSUME_NONNULL_END
