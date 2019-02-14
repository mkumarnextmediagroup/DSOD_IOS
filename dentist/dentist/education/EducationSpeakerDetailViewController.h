//
//  EducationSpeakerDetailViewController.h
//  dentist
//
//  Created by Shirley on 2019/2/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EducationSpeakerDetailViewController : UIViewController

/**
 open speaker detail page
 
 @param vc UIViewController
 @param dsoId dso id
 @param addReviewSuccessCallbak Add a comment success callback function
 */
+(void)openBy:(UIViewController*)vc dsoId:(NSString*)dsoId successCallbak:(void(^)(void))addReviewSuccessCallbak;

@end

NS_ASSUME_NONNULL_END
