//
//  CompanyDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyDetailViewController : BaseController

@property (nonatomic,strong) NSString *companyId;

+(void)openBy:(UIViewController*)vc companyId:(NSString*)companyId;

@end

NS_ASSUME_NONNULL_END
