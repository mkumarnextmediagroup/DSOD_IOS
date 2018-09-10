//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPage.h"
#import "GroupListPage.h"


//NSArray *arr = @[@"Alibaba", @"Aha", @"Alibaba1", @"Aha1", @"Alibaba2", @"Aha2", @"Alibaba3", @"Aha3", @"Alibaba4", @"Aha4", @"Alibaba5", @"Aha5", @"Alibaba6", @"Aha6", @"Cool", @"Yang", @"YangEntao", @"Yang1", @"YangEntao1", @"Yang2", @"YangEntao2", @"Yang3", @"YangEntao3", @"Yang4", @"YangEntao4", @"Yang5", @"YangEntao5", @"Yang6", @"YangEntao6"];
//SearchPage *c = [SearchPage new];
//c.titleText = @"Select State";
//c.withIndexBar = YES;
//[c setItemsPlain:arr displayBlock:^(NSObject *item) {
//NSString *s = (NSString *) item;
//return s;
//}];
//c.checkedItem = @"Yang";
//c.onResult = ^(NSObject *item) {
//	Log(@"Select: ", item);
//};
//[self pushPage:c];



@class Pair;


@interface SearchPage : GroupListPage

@property(nullable) NSString *titleText;

@property(nullable) NSObject *checkedItem;

@property(nullable) void ( ^  onResult)(NSObject *item);

@end