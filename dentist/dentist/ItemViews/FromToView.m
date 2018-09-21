//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "FromToView.h"
#import "Common.h"
#import "NSDate+myextend.h"

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

	_showPresentWhenGreatNow = NO;

	UILabel *fromLabel = self.addLabel;
	UILabel *toLabel = self.addLabel;
	[fromLabel itemTitleStyle];
	[toLabel itemTitleStyle];

	_fromDateLabel = self.addLabel;
	_toDateLabel = self.addLabel;
	[_fromDateLabel itemPrimaryStyle];
	[_toDateLabel itemPrimaryStyle];

	[fromLabel setTextWithDifColor:@"From *"];
	[toLabel setTextWithDifColor:@"To *"];

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


- (void)fromValue:(NSInteger)year month:(NSInteger)month {
	if (month > 0 && year > 0) {
		if (_showPresentWhenGreatNow) {
			NSInteger y = [[NSDate date] year];
			NSInteger m = [[NSDate date] month];
			if (year > y || (year == y && month > m)) {
				self.fromDateLabel.text = @"Present";
				return;
			}
		}
		self.fromDateLabel.text = strBuild(nameOfMonth(month), @" ", [@(year) description]);
	} else {
		self.fromDateLabel.text = @"Select";
	}


}

- (void)toValue:(NSInteger)year month:(NSInteger)month {
	if (month > 0 && year > 0) {
		if (_showPresentWhenGreatNow) {
			NSInteger y = [[NSDate date] year];
			NSInteger m = [[NSDate date] month];
			if (year > y || (year == y && month > m)) {
				self.toDateLabel.text = @"Present";
				return;
			}
		}
		self.toDateLabel.text = strBuild(nameOfMonth(month), @" ", [@(year) description]);
	} else {
		self.toDateLabel.text = @"Select";
	}
}

@end
