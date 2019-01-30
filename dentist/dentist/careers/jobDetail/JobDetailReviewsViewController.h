//
//  JobDetailReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyDetailReviewsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailReviewsViewController : CompanyDetailReviewsViewController

/**
 Get internal padding
 80px from the bottom to display the apply button
 
 @return UIEdgeInsets
 */
- (UIEdgeInsets)edgeInsetsMake;
@end

NS_ASSUME_NONNULL_END
