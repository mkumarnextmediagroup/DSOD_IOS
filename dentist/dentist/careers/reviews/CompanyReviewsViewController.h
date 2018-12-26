//
//  CompanyReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyReviewsViewController : UIViewController


+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel;

+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel onReviewNumChanged:(void(^)(NSInteger reviewNum))  _Nullable onReviewNumChanged;


@end

NS_ASSUME_NONNULL_END
