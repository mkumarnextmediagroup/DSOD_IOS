//
// Created by yet on 2018/8/16.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIUtil.h"

UIColor *rgb255(int r, int g, int b) {
	CGFloat fr = r / 255.0f;
	CGFloat fg = g / 255.0f;
	CGFloat fb = b / 255.0f;
	return [[UIColor alloc] initWithRed:fr green:fg blue:fb alpha:1.0];
}

UIColor *rgba255(int r, int g, int b, int a) {
	CGFloat fr = r / 255.0f;
	CGFloat fg = g / 255.0f;
	CGFloat fb = b / 255.0f;
	CGFloat fa = a / 255.0f;
	return [[UIColor alloc] initWithRed:fr green:fg blue:fb alpha:fa];
}