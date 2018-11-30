//
//  CompanyComment.h
//  dentist
//
//  Created by Shirley on 2018/11/30.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JobModel.h"
#import "CompanyCommentReviewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyCommentModel : JSONModel

@property NSString <Optional>*id;
@property NSString <Optional>*companyId;
@property NSString <Optional>*reviewTitle;
@property NSString <Optional>*pros;
@property NSString <Optional>*cons;
@property NSString <Optional>*advice;
@property BOOL isCurrentEmployee;
@property BOOL isFormerEmployee;
@property BOOL isRecommend;
@property BOOL isApprove;
@property NSString <Optional>*reviewDate;

@property NSString <Optional>*userId;
@property NSInteger rating;
@property NSInteger totalFound;
@property NSString <Optional>*email;
@property NSInteger reviewNum;
@property NSInteger recommendNum;
@property NSInteger approveNum;
@property NSString <Optional>*photo;
@property NSString <Optional>*photoUrl;
@property NSArray <CompanyCommentReviewsModel , Optional>*reviews;




@end

NS_ASSUME_NONNULL_END
