//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TitleSwitchView.h"
#import "Common.h"

@implementation TitleSwitchView {

}
- (instancetype)init {
	self = [super init];
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 16;
	self.layoutParam.height = 60;

	self.backgroundColor = UIColor.whiteColor;

	_titleLabel = self.addLabel;
	_switchView = [UISwitch new];
	_switchView.onTintColor = Colors.primary ;
	_switchView.tintColor = Colors.bgDisabled;
	_switchView.backgroundColor = Colors.bgDisabled;
	_switchView.layer.cornerRadius = 15.5f;
	_switchView.layer.masksToBounds = YES ;
	[self addSubview:_switchView];

	[_titleLabel itemTitleStyle];

	[[[[_switchView.layoutMaker sizeFit] rightParent:-p.right] centerYParent:0] install];

	[[[[[_titleLabel.layoutMaker heightEq:14] leftParent:p.left] toLeftOf:_switchView offset:-10] centerYParent:0] install];


	return self;
}

@end