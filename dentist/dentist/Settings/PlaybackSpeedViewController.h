//
//  PlaybackSpeedViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaybackSpeedViewController : UIViewController

+(void)openBy:(UIViewController*)vc;

+(NSString*)getCheckedPlaybackSpeedText;


@end

NS_ASSUME_NONNULL_END
