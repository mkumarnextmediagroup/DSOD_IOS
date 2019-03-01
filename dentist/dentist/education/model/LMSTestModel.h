//
//  LMSTestModel.h
//  dentist
//
//  Created by Shirley on 2019/3/1.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "DateTime.h"


NS_ASSUME_NONNULL_BEGIN

@interface LMSTestModel : JSONModel

@property NSString <Optional>*id;
@property NSString <Optional>*courseId;
@property NSString <Optional>*name;

@end

NS_ASSUME_NONNULL_END
