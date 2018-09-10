//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Pair : NSObject

@property NSString *key;
@property NSString *value;


+(instancetype) create:(NSString*) key  value:(NSString*) value ;

@end