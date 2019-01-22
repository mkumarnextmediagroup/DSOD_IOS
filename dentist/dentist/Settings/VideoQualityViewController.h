//
//  VideoQualityViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/5.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoQualityViewController : UIViewController

/**
 Open setting video quality page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc;

/**
 get selected video quality text
 @return video quality text
 */
+(NSString*)getCheckedVideoQualityText;

@end

NS_ASSUME_NONNULL_END
