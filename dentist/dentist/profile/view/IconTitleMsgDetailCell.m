//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "IconTitleMsgDetailCell.h"
#import "Common.h"

@implementation IconTitleMsgDetailCell {
	UIImageView *_imageView;
	UILabel *_titleLabel;
	UILabel *_msgLabel;
	UILabel *_detailLabel;
}
- (instancetype)init {
	self = [super init];
	_imageView = self.addImageView;
	_titleLabel = self.addLabel;
	_msgLabel = self.addLabel;
	_detailLabel = self.addLabel;

	[_imageView alignCenter];

	[_titleLabel textColorMain];
	_titleLabel.font = [Fonts semiBold:14];

	[_msgLabel textColorMain];
	_msgLabel.font = [Fonts regular:12];

	[_detailLabel textColorSecondary];
	_detailLabel.font = [Fonts regular:12];

	[[[[[_imageView layoutMaker] sizeEq:48 h:48] leftParent:18] centerYParent:0] install];
	[[[[[[_msgLabel layoutMaker] heightEq:14] centerYParent:0] leftParent:78] rightParent:0] install];
	[[[[[[_titleLabel layoutMaker] above:_msgLabel offset:-4] leftParent:78] rightParent:0] heightEq:16] install];
	[[[[[[_detailLabel layoutMaker] below:_msgLabel offset:2] leftParent:78] rightParent:0] heightEq:16] install];


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

- (UILabel *)detailLabel {
	return _detailLabel;
}

@end