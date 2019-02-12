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

/**
 open dso review detail page
 
 @param vc UIViewController
 @param jobDSOModel JobDSOModel instacne
 @param reviewModel CompanyReviewModel instance
 */
+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel companyReviewModel:(CompanyReviewModel*)reviewModel ;
/**
 view did load
 add navigation bar
 build views
 load data
 */
- (void)viewDidLoad;
/**
 add navigation bar
 */
-(void)addNavBar;
/**
 build views
 */
-(void)buildViews;
/**
 load data
 */
-(void)loadData;

@end

NS_ASSUME_NONNULL_END
