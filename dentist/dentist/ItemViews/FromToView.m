//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "FromToView.h"
#import "Common.h"

@implementation FromToView {

}
- (instancetype)init {
	self = [super init];
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 13;
	self.layoutParam.height = 76;

	self.backgroundColor = UIColor.whiteColor;

	UILabel *fromLabel = self.addLabel;
	UILabel *toLabel = self.addLabel;
	[fromLabel itemTitleStyle];
	[toLabel itemTitleStyle];

	_fromDateLabel = self.addLabel;
	_toDateLabel = self.addLabel;
	[_fromDateLabel itemPrimaryStyle];
	[_toDateLabel itemPrimaryStyle];

	fromLabel.text = @"From";
	toLabel.text = @"To";

	_fromDateLabel.text = @"Select";
	_toDateLabel.text = @"Select";

	UIImageView *leftArrow = [self addArrowView];
	UIImageView *rightArrow = [self addArrowView];

	MASConstraintMaker *mm = [[leftArrow.layoutMaker sizeFit] bottomParent:-p.bottom];
	mm.right.equalTo(self.mas_centerX).offset(-24);
	[mm install];


	[[[[rightArrow.layoutMaker sizeFit] rightParent:-p.right] bottomParent:-p.bottom] install];

	[[[[fromLabel.layoutMaker leftParent:p.left] topParent:p.top] sizeFit] install];
	[[[[[_fromDateLabel.layoutMaker leftParent:p.left] bottomParent:-p.bottom] heightEq:22] toLeftOf:leftArrow offset:-10] install];

	MASConstraintMaker *m = [[toLabel.layoutMaker topParent:p.top] sizeFit];
	m.left.equalTo(self.mas_centerX).offset(16);
	[m install];

	[[[[[_toDateLabel.layoutMaker bottomParent:-p.bottom] heightEq:22] leftOf:toLabel] rightParent:-32] install];

	UIView *leftLine = [self addView];
	leftLine.backgroundColor = Colors.cellLineColor;
	MASConstraintMaker *mLeft = [[[leftLine.layoutMaker bottomParent:-1] heightEq:1] leftParent:0];
	mLeft.right.equalTo(self.mas_centerX).offset(-8);
	[mLeft install];

	UIView *rightLine = [self addView];
	rightLine.backgroundColor = Colors.cellLineColor;
	MASConstraintMaker *mRight = [[[rightLine.layoutMaker bottomParent:-1] heightEq:1] rightParent:0];
	mRight.left.equalTo(self.mas_centerX).offset(8);
	[mRight install];


	return self;
}
@end