//
//  CompanyModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "CompanyMediaModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CompanyModel : JSONModel
@property NSString <Optional>*companyId;
@property NSString <Optional>*companyName;
@property NSString <Optional>*companyLogo;
@property NSString <Optional>*companyLogoUrl;
@property NSString <Optional>*webSiteUrl;
@property NSString <Optional>*companyCEOName;
@property NSString <Optional>*companyCEOPhoto;
@property NSString <Optional>*companyCEOPhotoUrl;
@property NSString <Optional>*companyDesc;
@property NSString <Optional>*address;
@property NSString <Optional>*companyLocation;
@property NSArray  <Optional>*position;
@property NSString <Optional>*foundingTime;
@property CompanyMediaModel <Optional>*media;
@property NSInteger rating;
@property NSInteger reviews;
@property NSString <Optional>*contactPerson;
//@property NSInteger createdDate;
//@property NSInteger modifiedDate;
//@property NSInteger employees;
@property NSString <Optional>*stage;

@end

NS_ASSUME_NONNULL_END
