//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TitleMsgArrowView.h"
#import "Padding.h"
#import "Fonts.h"
#import "Common.h"

@implementation TitleMsgArrowView {

}

- (instancetype)init {
	self = [super init];
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 16;

	self.backgroundColor = UIColor.whiteColor;

	_titleLabel = self.addLabel;
	_msgLabel = self.addLabel;
	UIImageView *iconView = self.addImageView;

	_titleLabel.font = [Fonts regular:12];
	[_titleLabel textColorSecondary];

	_msgLabel.font = [Fonts regular:15];
	[_msgLabel textColorBlack];

	iconView.imageName = @"arrow_small";

	[[[[[_titleLabel.layoutMaker heightEq:14] leftParent:p.left] rightParent:-p.right] topParent:p.top] install];
	[[[[iconView.layoutMaker sizeEq:16 h:16] rightParent:-p.right] bottomParent:-p.bottom] install];
	[[[[[_msgLabel.layoutMaker heightEq:25] leftParent:p.left] bottomParent:-p.bottom] toLeftOf:iconView offset:10] install];


	return self;
}
@end