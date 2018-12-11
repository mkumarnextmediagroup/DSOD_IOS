//
//  JobDSOModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/11.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JobPosition.h"
#import "CompanyMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDSOModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*name;
@property NSString <Optional>*ceo;
@property NSString <Optional>*address1;
@property NSString <Optional>*address2;
@property NSString <Optional>*city;
@property NSString <Optional>*state;
@property NSString <Optional>*zip_code;
@property NSString <Optional>*employees;
@property NSString <Optional>*stage;
@property NSString <Optional>*year_of_foundation;
@property NSString <Optional>*url;
@property NSString <Optional>*logo;
@property NSString <Optional>*logoURL;
@property BOOL is_sponsor;
@property JobPosition <Optional>*position;
@property CompanyMediaModel <Optional>*media;
@property NSArray <Optional>*mediaURL;
@property NSString <Optional>*dsoDescription;
@property double rating;
@property NSInteger totalFound;
@property NSInteger reviewNum;
@property NSInteger recommendNum;
@property NSInteger approveNum;
@end

NS_ASSUME_NONNULL_END
