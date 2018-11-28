//
//  JobBookmarkModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JobModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JobBookmarkModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*userId;
@property NSString <Optional>*url;
@property NSString <Optional>*title;
@property NSString <Optional>*jobId;
@property NSString <Optional>*create_time;
@property JobModel <Optional>*jobPO;
@end

NS_ASSUME_NONNULL_END
