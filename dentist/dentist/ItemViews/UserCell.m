//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserCell.h"
#import "Common.h"

@implementation UserCell {
}
- (instancetype)init {
	self = [super init];
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 16;
	self.layoutParam.height = 94;

	_imageView = self.addImageView;
	_nameLabel = self.addLabel;
	_specTitleLabel = self.addLabel;
	_specNameLabel = self.addLabel;

	[_imageView alignCenter];

	_nameLabel.textColor = UIColor.blackColor;
	_nameLabel.font = [Fonts semiBold:17];

	[_specTitleLabel textColorSecondary];
	_specTitleLabel.font = [Fonts regular:12];
	_specTitleLabel.text = @"Speciality";

	[_specNameLabel textColorMain];
	_specNameLabel.font = [Fonts semiBold:14];

	[[[[[_imageView layoutMaker] sizeEq:70 h:70] leftParent:p.left] centerYParent:0] install];

	[[[[[[_nameLabel layoutMaker] toRightOf:_imageView offset:15] topOf:_imageView offset:2] rightParent:-p.right] heightEq:20] install];
	[[[[[[_specTitleLabel layoutMaker] toRightOf:_imageView offset:15] heightEq:14] topParent:46] rightParent:-p.right] install];
	[[[[[[_specNameLabel layoutMaker] toRightOf:_imageView offset:15] topParent:64] rightParent:-p.right] heightEq:16] install];


	return self;
}


@end