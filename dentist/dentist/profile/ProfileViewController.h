//
//  ProfileViewController.h
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "BaseController.h"
#import "ScrollPage.h"
#import "UserInfo.h"

@interface ProfileViewController : ScrollPage
@property UserInfo *userInfo;
@property BOOL isSecond;

- (void)buildViews;
@end
