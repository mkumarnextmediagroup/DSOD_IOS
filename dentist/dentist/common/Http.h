//
// Created by yet on 2018/8/20.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Http : NSObject

@property NSString *url;


//NSString, NSNumber
- (void)arg:(NSString *)name value:(NSObject *)value;

@end