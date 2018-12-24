//
//  CompanyReviewsDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/23.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyReviewModel.h"
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyReviewsDetailViewController : UIViewController


+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel companyReviewModel:(CompanyReviewModel*)reviewModel ;

@end

NS_ASSUME_NONNULL_END
