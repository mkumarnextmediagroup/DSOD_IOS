//
//  CareerJobDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^CareerJobDetailCloseCallback) (void);
@interface CareerJobDetailViewController : BaseController

@property (nonatomic,strong) NSString *jobId;
@property (copy, nonatomic) CareerJobDetailCloseCallback closeBack;


+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*)jobId;
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*)jobId closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;
@end

NS_ASSUME_NONNULL_END
