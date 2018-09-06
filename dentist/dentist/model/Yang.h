//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "Education.h"


@interface Yang : JSONModel

@property NSString *name;
@property NSInteger age;

@property NSArray <Education> *edu;

@end