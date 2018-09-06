//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Toast.h"
#import "Fonts.h"
#import "Common.h"


@implementation Toast {

}

- (instancetype)init {
	self = [super init];

	self.y = SCREENHEIGHT / 2;
	self.font = [Fonts regular:12];
	self.backColor = Colors.secondary;
	self.textColor = [UIColor whiteColor];
	self.timeout = 5000;

	return self;
}

- (void)below:(UIView *)v offsetY:(CGFloat)offsetY {
	CGRect r = [v toScreenFrame];
	self.y = r.origin.y + r.size.height + offsetY;
}


- (void)show {

}


@end