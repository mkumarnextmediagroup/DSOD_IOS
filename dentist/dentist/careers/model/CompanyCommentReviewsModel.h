//
//  CompanyCommentreviewsModel.h
//  dentist
//
//  Created by Shirley on 2018/11/30.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol CompanyCommentReviewsModel
@end

@interface CompanyCommentReviewsModel : JSONModel

@property NSString <Optional>*reviewTitle;
@property NSString <Optional>*pros;
@property NSString <Optional>*cons;
@property NSString <Optional>*advice;
@property BOOL isCurrentEmployee;
@property BOOL isFormerEmployee;
@property BOOL isRecommend;
@property BOOL isApprove;
@property long long reviewDate;


@end

NS_ASSUME_NONNULL_END
