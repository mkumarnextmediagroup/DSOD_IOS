//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroupItem : NSObject

@property(nullable) NSString *title;

@property(nonnull, readonly) NSMutableArray *children;

@property(nullable) NSObject *arg;

@end