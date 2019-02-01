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

/**
 Open setting playback speed page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc;


/**
 get selected playback speed text
 @return playback speed text
 */
+(NSString*)getCheckedPlaybackSpeedText;


@end

NS_ASSUME_NONNULL_END
