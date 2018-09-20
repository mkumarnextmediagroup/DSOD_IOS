//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TitleMsgArrowView.h"
#import "Padding.h"
#import "Fonts.h"
#import "Common.h"

@implementation TitleMsgArrowView {
	UIImageView *iconView;
}

- (instancetype)init {
	self = [super init];
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 16;
	self.layoutParam.height = 78;

	self.backgroundColor = UIColor.whiteColor;

	_titleLabel = self.addLabel;
	_msgLabel = self.addLabel;
	iconView = self.addImageView;

	[_titleLabel itemTitleStyle];

	_msgLabel.font = [Fonts regular:15];
	[_msgLabel textColorBlack];
	_msgLabel.numberOfLines = 0;

	iconView.imageName = @"arrow_small";

	[[[[[_titleLabel.layoutMaker heightEq:14] leftParent:p.left] rightParent:-p.right] topParent:p.top] install];
	[[[[iconView.layoutMaker sizeEq:16 h:16] rightParent:-p.right] bottomParent:-p.bottom - 5] install];
	[[[[[_msgLabel.layoutMaker heightEq:25] leftParent:p.left] bottomParent:-p.bottom] toLeftOf:iconView offset:-20] install];


	return self;
}

- (void)resetLayout {
	CGSize sz = [_msgLabel sizeThatFits:makeSize(310, 1000)];
	[[_msgLabel.layoutUpdate heightEq:sz.height] install];
	self.layoutParam.height = 78 + (sz.height - 25);

}
@end
