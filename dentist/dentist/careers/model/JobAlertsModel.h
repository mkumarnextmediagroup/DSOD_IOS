//
//  JobAlertsModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JobAlertsModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*keyword;
@property NSString <Optional>*location;
@property NSArray <Optional>*position;
@property NSInteger distance;
@property NSInteger frequency;
@property NSString <Optional>*userId;
@property NSString <Optional>*email;
@property BOOL status;
@end

NS_ASSUME_NONNULL_END
