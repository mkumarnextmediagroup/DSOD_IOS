//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IconLabelView : UIControl

@property(readonly) UIImageView *imageView;
@property(readonly) UILabel *labelView;

+ (IconLabelView *)make:(NSString *)icon label:(NSString *)label;

@end