//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserCell.h"
#import "Common.h"

@implementation UserCell {
	UIImageView *_imageView;
	UILabel *_nameLabel;
	UILabel *_specTitleLabel;
	UILabel *_specNameLabel;
}
- (instancetype)init {
	self = [super init];
	_imageView = self.addImageView;
	_nameLabel = self.addLabel;
	_specTitleLabel = self.addLabel;
	_specNameLabel = self.addLabel;

	[_imageView alignCenter];

	_nameLabel.textColor = UIColor.blackColor;
	_nameLabel.font = [Fonts semiBold:17];

	[_specTitleLabel textColorSecondary];
	_specTitleLabel.font = [Fonts regular:12];

	[_specNameLabel textColorMain];
	_specNameLabel.font = [Fonts semiBold:14];

	[[[[[_imageView layoutMaker] sizeEq:70 h:70] leftParent:18] centerYParent:0] install];

	[[[[[[_nameLabel layoutMaker] topOf:_imageView offset:2] leftParent:102] rightParent:0] heightEq:20] install];
	[[[[[[_specTitleLabel layoutMaker] heightEq:14] topParent:46] leftParent:102] rightParent:0] install];
	[[[[[[_specNameLabel layoutMaker] topParent:64] leftParent:102] rightParent:0] heightEq:16] install];


	return self;
}

- (UIImageView *)imageView {
	return _imageView;
}

- (UILabel *)_titleLabel {
	return _nameLabel;
}

- (UILabel *)specTitleLabel {
	return _specTitleLabel;
}

- (UILabel *)specNameLabel {
	return _specNameLabel;
}

@end