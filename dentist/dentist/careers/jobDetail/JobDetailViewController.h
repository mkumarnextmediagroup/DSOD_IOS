//
//  JobDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

typedef void (^CareerJobDetailCloseCallback) (NSString *_Nullable jobid);
@interface JobDetailViewController : BaseController

+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nullable)jobId;
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nonnull)jobId closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nonnull)jobId isShowApply:(BOOL)isShowApply closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;


@end
