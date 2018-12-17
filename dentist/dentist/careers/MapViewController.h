//
//  MapViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/12.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController

+(void)openBy:(UIViewController*)vc latitude:(double)latitude longitude:(double)longitude title:(NSString*)title subTitle:subTitle;

@end

NS_ASSUME_NONNULL_END
