//
//  Author.h
//  dentist
//
//  Created by 孙兴国 on 2018/11/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Author : JSONModel

@property NSString <Optional>*_id;
@property NSInteger sort;
@property NSString <Optional>*firstName;
@property NSString <Optional>*lastName;
@property NSString <Optional>*authorDetails;
@property NSString <Optional>*email;
@property NSString <Optional>*cellphone;
@property NSString <Optional>*role;
@property NSString <Optional>*ojectId;

@end

NS_ASSUME_NONNULL_END
