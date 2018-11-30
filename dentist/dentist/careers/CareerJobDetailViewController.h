//
//  CareerJobDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CareerJobDetailViewController : UIViewController

@property (nonatomic,strong) NSString *jobId;


+(void)presentBy:(UIViewController*)vc jobId:(NSString*)jobId;

@end

NS_ASSUME_NONNULL_END
