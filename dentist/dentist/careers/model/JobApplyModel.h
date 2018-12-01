//
//  JobApplyModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JobModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JobApplyModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*userId;
@property NSString <Optional>*jobId;
@property JobModel <Optional>*jobPO;
@property NSString <Optional>*createDate;
@end

NS_ASSUME_NONNULL_END
