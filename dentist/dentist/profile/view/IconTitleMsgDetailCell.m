//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "IconTitleMsgDetailCell.h"
#import "Common.h"

@implementation IconTitleMsgDetailCell {
	BOOL _hasArrow;
	UIImageView *arrowView;
}
- (instancetype)init {
	self = [super init];
	_hasArrow = NO;
	arrowView = nil;

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

	arrowView = self.addImageView;
	arrowView.imageName = @"arrow_small";
	arrowView.hidden = YES;

	[[[[[_imageView layoutMaker] sizeEq:48 h:48] leftParent:18] centerYParent:0] install];
	[[[[[[_msgLabel layoutMaker] heightEq:14] centerYParent:0] leftParent:78] rightParent:0] install];
	[[[[[[_titleLabel layoutMaker] above:_msgLabel offset:-4] leftParent:78] rightParent:0] heightEq:16] install];
	[[[[[[_detailLabel layoutMaker] below:_msgLabel offset:2] leftParent:78] rightParent:0] heightEq:16] install];
	[[[[[arrowView layoutMaker] centerYParent:0] rightParent:-16] sizeEq:16 h:16] install];

	self.layoutParam.height = 78;

	return self;
}

- (BOOL)hasArrow {
	return _hasArrow;
}

- (void)setHasArrow:(BOOL)hasArrow {
	_hasArrow = hasArrow;
	arrowView.hidden = !_hasArrow;
}


@end