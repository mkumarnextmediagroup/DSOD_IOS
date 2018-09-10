//
//  EditExperiencePage.h
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ScrollPage.h"

@class UserInfo;
@class Experience;

@interface EditExperiencePage : ScrollPage


@property BOOL isAdd;
@property UserInfo *userInfo;

@property(nonnull) Experience *exp;

@end
