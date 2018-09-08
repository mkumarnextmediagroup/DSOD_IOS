//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScrollPage : UIViewController


@property(readonly) UIScrollView *scrollView;
@property(readonly) UIView *contentView;

//返回最底部的view;
- (UIView *)onCreateContent;


@end