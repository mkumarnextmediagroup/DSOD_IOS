//
//  JobModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "CompanyModel.h"
#import "JobPosition.h"
NS_ASSUME_NONNULL_BEGIN

@interface JobModel : NSObject
@property NSString <Optional>*id;
@property NSString <Optional>*jobTitle;
@property NSString <Optional>*categroy;
@property NSInteger salaryStartingValue;
@property NSInteger salaryEndValue;
@property NSString <Optional>*salaryRange;
@property NSInteger experienceStartingValue;
@property NSInteger experienceEndValue;
@property NSString <Optional>*experienceRange;
@property NSInteger status;
@property NSString <Optional>*modifiedDate;
@property NSString <Optional>*publishDate;
@property NSString <Optional>*createDate;
@property NSString <Optional>*jobDescription;
@property NSString <Optional>*companyId;
@property CompanyModel <Optional>*company;
@property NSString <Optional>*isAttention;
@property NSString <Optional>*location;
@property JobPosition <Optional>*position;
@property NSString <Optional>*isApplication;

@end

NS_ASSUME_NONNULL_END
