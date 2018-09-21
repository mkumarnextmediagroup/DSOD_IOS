//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseItemView.h"


@interface FromToView : BaseItemView


@property UILabel *fromDateLabel;
@property UILabel *toDateLabel;

@property BOOL showPresentWhenGreatNow;


- (void)fromValue:(NSInteger)year month:(NSInteger)month;

- (void)toValue:(NSInteger)year month:(NSInteger)month;

@end