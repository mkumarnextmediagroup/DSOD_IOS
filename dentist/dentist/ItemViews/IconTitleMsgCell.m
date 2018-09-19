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
	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 16;
	self.layoutParam.height = 78;

	_imageView = self.addImageView;
	_titleLabel = self.addLabel;
	_msgLabel = self.addLabel;

	[_imageView alignCenter];

	[_titleLabel textColorMain];
	_titleLabel.font = [Fonts semiBold:14];

	[_msgLabel textColorMain];
	_msgLabel.font = [Fonts regular:12];
	_msgLabel.numberOfLines = 0;

	[[[[[_imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
	[[[[[[_titleLabel layoutMaker] topParent:16] toRightOf:_imageView offset:14] rightParent:-self.padding.right] heightEq:20] install];
	[[[[[[_msgLabel layoutMaker] bottomParent:-16] toRightOf:_imageView offset:14] rightParent:-self.padding.right] heightGe:24] install];


	return self;
}

- (void)resetLayout {
	[[[[[_imageView layoutRemaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
	[[[[[[_titleLabel layoutRemaker] topParent:16] toRightOf:_imageView offset:14] rightParent:-self.padding.right] heightEq:20] install];
	[[[[[[_msgLabel layoutRemaker] bottomParent:-16] toRightOf:_imageView offset:14] rightParent:-self.padding.right] heightGe:24] install];


}


@end