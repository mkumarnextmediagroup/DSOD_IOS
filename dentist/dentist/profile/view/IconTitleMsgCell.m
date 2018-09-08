//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "IconTitleMsgCell.h"
#import "Common.h"


@implementation IconTitleMsgCell {
	UIImageView *_imageView;
	UILabel *_titleLabel;
	UILabel *_msgLabel;
}

- (instancetype)init {
	self = [super init];
	_imageView = self.addImageView;
	_titleLabel = self.addLabel;
	_msgLabel = self.addLabel;

	[_imageView alignCenter];

	[_titleLabel textColorMain];
	_titleLabel.font = [Fonts semiBold:14];

	[_msgLabel textColorMain];
	_msgLabel.font = [Fonts regular:12];

	[[[[[_imageView layoutMaker] sizeEq:48 h:48] leftParent:18] centerYParent:0] install];
	[[[[[[_titleLabel layoutMaker] centerYParent:-8] leftParent:78] rightParent:0] heightEq:16] install];
	[[[[[[_msgLabel layoutMaker] centerYParent:10] leftParent:78] rightParent:0] heightEq:16] install];


	return self;
}

- (UIImageView *)imageView {
	return _imageView;
}

- (UILabel *)titleLabel {
	return _titleLabel;
}

- (UILabel *)msgLabel {
	return _msgLabel;
}

@end