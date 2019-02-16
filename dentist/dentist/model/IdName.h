//
// Created by entaoyang on 2018/9/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Optional;


@interface IdName : JSONModel

@property NSString *id;

@property NSString <Optional> *name;

@property NSString <Optional> *descriptions;

@end
