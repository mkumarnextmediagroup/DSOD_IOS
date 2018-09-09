//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "LabelCheckView.h"
#import "Common.h"


@implementation LabelCheckView {

}

- (instancetype)init {
	self = [super init];
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 10;
	p.bottom = 10;


	_label = [self addLabel];
	_checkButton = [self addButton];

	_label.font = [Fonts regular:15];
	[_label textColorBlack];

	[_checkButton setBackgroundImage:[UIImage imageNamed:@"unSelect"] forState:UIControlStateNormal];
	[_checkButton setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];

	[[[[[_label.layoutMaker leftParent:p.left] centerYParent:0] rightParent:-50] heightEq:24] install];
	[[[[_checkButton.layoutMaker rightParent:-p.right] centerYParent:0] sizeEq:16 h:16] install];


	return self;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	_checkButton.selected = self.selected;
}

@end