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

@interface JobModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*jobTitle;
@property NSString <Optional>*categroy;
@property NSString <Optional>*jobDescription;
@property NSInteger salaryStartingValue;
@property NSInteger salaryEndValue;
@property NSString <Optional>*salaryRange;
//@property NSInteger experienceStartingValue;
//@property NSInteger experienceEndValue;
//@property NSString <Optional>*experienceRange;
@property NSInteger status;
@property NSString <Optional>*modifiedDate;
//@property NSString <Optional>*publishDate;
@property NSString <Optional>*publishOn;
@property NSString <Optional>*publishEnd;
@property NSString <Optional>*createDate;
@property NSString <Optional>*companyId;
@property NSString <Optional>*company;
@property CompanyModel <Optional>*dso;
@property NSString <Optional>*isAttention;
@property NSString <Optional>*location;
@property JobPosition <Optional>*position;
@property NSString <Optional>*isApplication;
@property NSString <Optional>*address;
@property NSInteger companyType;
@property BOOL paid;
@property NSString <Optional>*city;
@property NSString <Optional>*state;
@property NSString <Optional>*zipCode;

@end

NS_ASSUME_NONNULL_END
