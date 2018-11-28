//
//  JobPosition.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JobPosition : JSONModel
@property NSString <Optional>*type;
@property NSArray <Optional>*coordinates;
@end

NS_ASSUME_NONNULL_END
