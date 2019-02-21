//
//  CourseDetailViewController.h
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailViewController : UIViewController

/**
 present course detail page
 
 @param vc UIViewController
 @param courseId course id
 */
+(void)presentBy:(UIViewController*)vc courseId:(NSString*)courseId;

/**
 open course detail page
 
 @param vc UIViewController
 @param courseId course id
 */
+(void)openBy:(UIViewController*)vc courseId:(NSString*)courseId;


@end

NS_ASSUME_NONNULL_END
