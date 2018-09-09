//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScrollPage : UIViewController


@property(readonly) UIScrollView *scrollView;
@property(readonly) UIView *contentView;

- (void)layoutLinearVertical;

-(UIView*)addGrayLine:(CGFloat)marginLeft marginRight:(CGFloat) marginRight;
@end