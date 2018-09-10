//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "GroupListPage.h"

@class Pair;


@interface SearchPage : GroupListPage

@property(nullable) NSString *titleText;

@property(nullable) NSObject *checkedItem;

@property(nullable) void ( ^  onResult)(NSObject *item);

@end