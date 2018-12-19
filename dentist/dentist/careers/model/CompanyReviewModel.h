//
//  CompanyCommentreviewsModel.h
//  dentist
//
//  Created by Shirley on 2018/11/30.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface CompanyReviewModel : JSONModel

@property NSString <Optional>*id;
@property NSString <Optional>*dsoId;
@property NSString <Optional>*reviewTitle;
@property NSString <Optional>*pros;
@property NSString <Optional>*cons;
@property NSString <Optional>*advice;
@property BOOL isCurrentEmployee;
@property BOOL isFormerEmployee;
@property BOOL isRecommend;
@property BOOL isApprove;
@property long long reviewDate;
@property NSString <Optional>*email;
@property NSString <Optional>*userId;
@property NSInteger rating;

    
@end

NS_ASSUME_NONNULL_END
