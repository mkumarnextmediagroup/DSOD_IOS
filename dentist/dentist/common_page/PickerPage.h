//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PickerPage : UIViewController

@property(nonnull) NSArray<NSArray *> *data;
@property(nullable) NSArray *preSelectData;

@property(nullable) void (^resultCallback)(NSArray *columns);
@property(nullable) NSString *(^displayBlock)(NSObject *item);


+ (PickerPage *)pickYearMonth:(NSInteger)yearFrom yearTo:(NSInteger)yearTo;

+ (PickerPage *)pickYearMonthFromNowDownTo:(NSInteger)yearTo;

@end