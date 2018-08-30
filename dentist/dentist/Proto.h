//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@class HttpResult;


@interface Proto : NSObject

+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name;

@end