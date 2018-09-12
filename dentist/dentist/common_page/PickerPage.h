//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PickerPage : UIViewController

@property(nonnull) NSArray<NSArray *> *data;
@property(nullable) NSArray *preSelectData;
@property(nonnull) NSArray<NSArray *> *showArr;

@property(nullable) void (^resultCallback)(NSArray * _Nullable columns);
@property(nullable) NSString *_Nullable(^displayBlock)(NSObject * _Nullable item);


+ (PickerPage *_Nullable)pickYearMonth:(NSInteger)yearFrom yearTo:(NSInteger)yearTo;

+ (PickerPage *_Nullable)pickYearMonthFromNowDownTo:(NSInteger)yearTo;

@end
