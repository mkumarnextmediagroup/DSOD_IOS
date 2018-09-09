//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "IconTitleMsgCell.h"
#import "Common.h"


@implementation IconTitleMsgCell {

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
	_msgLabel.numberOfLines = 0;

	[[[[[_imageView layoutMaker] sizeEq:48 h:48] leftParent:18] centerYParent:0] install];
	[[[[[[_titleLabel layoutMaker] topOf:_imageView offset:0] leftParent:78] rightParent:0] heightEq:20] install];
	[[[[[[_msgLabel layoutMaker] bottomOf:_imageView offset:0] leftParent:78] rightParent:0] heightGe:24] install];

	self.layoutParam.height = 78;

	return self;
}


@end