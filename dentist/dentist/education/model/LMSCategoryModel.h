//
//  LMSCategoryModel.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LMSCategoryModel  : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*name;
@property NSString <Optional>*descriptions;
@property NSString <Optional>*parentId;
@property NSInteger sort;
@property NSInteger countofcourse;
@end

NS_ASSUME_NONNULL_END
