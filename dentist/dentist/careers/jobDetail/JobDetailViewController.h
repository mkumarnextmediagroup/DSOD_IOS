//
//  JobDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^CareerJobDetailCloseCallback) (void);
@interface JobDetailViewController : BaseController

+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*)jobId;
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*)jobId closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;


@end

NS_ASSUME_NONNULL_END
