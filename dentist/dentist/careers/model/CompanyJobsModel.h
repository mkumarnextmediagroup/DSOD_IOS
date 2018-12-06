//
//  CompanyJobsModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JobModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CompanyJobsModel : JSONModel
@property NSString <Optional>*companyId;
@property NSString <Optional>*logo;
@property NSString <Optional>*logoUrl;
@property NSString <Optional>*companyName;
@property NSArray  <JobModel *> <Optional>*jobsOfCompanies;
@end

NS_ASSUME_NONNULL_END
