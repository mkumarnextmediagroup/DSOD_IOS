//
//  CompanyModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyModel : NSObject
@property NSString <Optional>*id;
@property NSString <Optional>*companyName;
@property NSString <Optional>*companyLogo;
@property NSString <Optional>*webSiteUrl;
@property NSString <Optional>*companyCEOName;
@property NSString <Optional>*companyCEOPhoto;
@property NSString <Optional>*companyDesc;
@property NSString <Optional>*address;
@property NSString <Optional>*companyLocation;
@property NSString <Optional>*position;
@property NSString <Optional>*companyPicture;
@property NSString <Optional>*foundingTime;
@property NSInteger rating;
@property NSString <Optional>*contactPerson;
@property NSString <Optional>*createdDate;
@property NSString <Optional>*modifiedDate;
@property NSString <Optional>*employees;
@end

NS_ASSUME_NONNULL_END
