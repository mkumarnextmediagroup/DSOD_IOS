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

	Padding *p = self.padding;
	p.left = 16;
	p.right = 16;
	p.top = 16;
	p.bottom = 16;
	self.layoutParam.height = 78;

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

	_emptyLabel = [self addLabel];
	_emptyLabel.font = [Fonts regular:14];
	[_emptyLabel textColorAlternate];
	_emptyLabel.hidden = YES;

	[[[[[_imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
	[[[[[[_titleLabel layoutMaker] heightEq:16] topOf:_imageView offset:-2] toRightOf:_imageView offset:12] rightParent:-self.padding.right] install];
	[[[[[[_msgLabel layoutMaker] heightEq:16] centerYParent:2] toRightOf:_imageView offset:12] rightParent:-self.padding.right] install];
	[[[[[[_detailLabel layoutMaker] heightEq:16] bottomOf:_imageView offset:2] toRightOf:_imageView offset:12] rightParent:-self.padding.right] install];
	[[[[[arrowView layoutMaker] centerYParent:0] rightParent:-self.padding.right] sizeEq:16 h:16] install];
	[[[[[_emptyLabel.layoutMaker toRightOf:_imageView offset:12] centerYParent:0] heightEq:18] rightParent:-self.padding.right] install];

	self.layoutParam.height = 78;

	return self;
}

- (void)showEmpty:(NSString *)text {
	_titleLabel.hidden = YES;
	_msgLabel.hidden = YES;
	_detailLabel.hidden = YES;
	_emptyLabel.hidden = NO;
	_emptyLabel.text = text;
}

- (void)hideEmpty {
	_titleLabel.hidden = NO;
	_msgLabel.hidden = NO;
	_detailLabel.hidden = NO;
	_emptyLabel.hidden = YES;
}

- (BOOL)hasArrow {
	return _hasArrow;
}

- (void)setHasArrow:(BOOL)hasArrow {
	_hasArrow = hasArrow;
	arrowView.hidden = !_hasArrow;
}

- (void)resetLayout {
	[[[[[_imageView layoutRemaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
	[[[[[[_titleLabel layoutRemaker] heightEq:16] topOf:_imageView offset:0] leftParent:self.padding.left + 48] rightParent:-self.padding.right] install];
	[[[[[[_msgLabel layoutRemaker] heightEq:16] centerYParent:0] leftParent:self.padding.left + 48] rightParent:-self.padding.right] install];
	[[[[[[_detailLabel layoutRemaker] heightEq:16] bottomOf:_imageView offset:0] leftParent:self.padding.left + 48] rightParent:-self.padding.right] install];
	[[[[[arrowView layoutRemaker] centerYParent:0] rightParent:-self.padding.right] sizeEq:16 h:16] install];

}

@end