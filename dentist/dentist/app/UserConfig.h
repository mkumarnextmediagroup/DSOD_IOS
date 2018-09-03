//
// Created by entaoyang on 2018/8/31.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserConfig : NSObject

+ (NSUserDefaults *)account:(NSString *)account;

+ (NSUserDefaults *)standard:(NSString *)account;


@end