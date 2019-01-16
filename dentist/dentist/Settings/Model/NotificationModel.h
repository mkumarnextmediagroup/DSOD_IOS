//
//  NotificationModel.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*userId;
@property BOOL uniteMagazine;
@property BOOL education;
@property BOOL events;
@property BOOL career;
@end

NS_ASSUME_NONNULL_END
