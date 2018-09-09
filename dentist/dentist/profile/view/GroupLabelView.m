//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "GroupLabelView.h"
#import "Common.h"


@implementation GroupLabelView {
	UIButton *btn;
}
- (instancetype)init {
	self = [super init];
	self.backgroundColor = UIColor.whiteColor;
	self.padding.left = 16;
	self.padding.right = 16;
	_label = self.addLabel;
	[_label textColorSecondary];
	_label.font = [Fonts regular:12];
	[[[[[_label.layoutMaker leftParent:self.padding.left] rightParent:-50] centerYParent:0] heightEq:20] install];

	btn = nil;


	self.layoutParam.height = 26;
	return self;
}

- (UIButton *)button {
	if (btn == nil) {
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:btn];
		[btn setImage:[UIImage imageNamed:@"add_light"] forState:UIControlStateNormal];
		[btn.imageView alignCenter];
		[[[[btn.layoutMaker rightParent:-self.padding.right] centerYParent:0] sizeEq:23 h:23] install];
	}

	return btn;
}

@end