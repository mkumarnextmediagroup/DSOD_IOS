//
//  CareerAddReviewViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/11.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CareerAddReviewViewController : UIViewController

@property (nonatomic,strong) NSString *dsoId;

+(void)openBy:(UIViewController*)vc dsoId:(NSString*)dsoId;
@end

NS_ASSUME_NONNULL_END
