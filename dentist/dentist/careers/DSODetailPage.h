//
//  DSODetailPage.h
//  dentist
//
//  Created by Jacksun on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
NS_ASSUME_NONNULL_BEGIN
@interface DSODetailPage : BaseController

@property (nonatomic,strong) NSString *companyId;


+(void)openBy:(UIViewController*)vc companyId:(NSString*)companyId;

NS_ASSUME_NONNULL_END
@end
