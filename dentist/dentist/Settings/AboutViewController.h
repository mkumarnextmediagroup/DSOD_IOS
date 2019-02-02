//
//  AboutViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/5.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutViewController : UIViewController


/**
 Open about page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc ;


/**
 add navigation bar
 */
-(void)addNavBar;

/**
 build views
 */
-(void)buildViews;
    

/**
 DentistTabView Delegate
 Tab change callback
 @param index Currently selected tab index
 */
- (void)didDentistSelectItemAtIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
