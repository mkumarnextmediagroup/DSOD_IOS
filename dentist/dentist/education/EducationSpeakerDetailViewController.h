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
 @param authorId author id
 */
+(void)openBy:(UIViewController*)vc authorId:(NSString*)authorId;

/**
 view did load
 add navigation bar
 build views
 get author info form server
 */
- (void)viewDidLoad ;

/**
 add navigation bar
 */
-(void)addNavBar;

/**
 build views
 */
-(void)buildViews;

/**
 get author info form server
 */
-(void)loadData;

/**
 show author info
 
 @param authorModel AuthorModel
 */
-(void)showData:(AuthorModel *)authorModel;

@end

NS_ASSUME_NONNULL_END
