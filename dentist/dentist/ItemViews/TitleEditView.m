//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TitleEditView.h"
#import "Fonts.h"
#import "Common.h"


@implementation TitleEditView {
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

	_label = self.addLabel;
	_edit = self.addEditRaw;
	iconView = self.addImageView;

	[_label graySmallStyle];

	_edit.font = [Fonts regular:15];
	[_edit textColorBlack];

	iconView.imageName = @"write";

	[[[[[_label.layoutMaker heightEq:14] leftParent:p.left] rightParent:-p.right] topParent:p.top] install];
	[[[[iconView.layoutMaker sizeEq:16 h:16] rightParent:-p.right] bottomParent:-p.bottom] install];
	[[[[[_edit.layoutMaker heightEq:25] leftParent:p.left] bottomParent:-p.bottom] toLeftOf:iconView offset:10] install];


	return self;
}

- (void)resetLayout {
	Padding *p = self.padding;
	[[[[[_label.layoutRemaker heightEq:14] leftParent:p.left] rightParent:-p.right] topParent:p.top] install];
	[[[[iconView.layoutRemaker sizeEq:16 h:16] rightParent:-p.right] bottomParent:-p.bottom] install];
	[[[[[_edit.layoutRemaker heightEq:25] leftParent:p.left] bottomParent:-p.bottom] toLeftOf:iconView offset:10] install];

}
@end