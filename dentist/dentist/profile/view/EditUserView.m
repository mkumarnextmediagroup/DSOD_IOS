//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "EditUserView.h"
#import "Colors.h"
#import "Common.h"


@implementation EditUserView {

}

- (instancetype)init {
	self = [super init];
	UILabel *noticeLab = [[UILabel alloc] init];
	noticeLab.textColor = Colors.textAlternate;
	noticeLab.font = [Fonts regular:12];
	noticeLab.text = @"profile photo";
	noticeLab.textAlignment = NSTextAlignmentCenter;
	[self addSubview:noticeLab];
	[[[[noticeLab.layoutMaker sizeEq:100 h:20] topParent:22] centerXParent:0] install];

	_headerImg = [UIImageView new];
	_headerImg.imageName = @"headerImage";
	[_headerImg sd_setImageWithURL:[NSURL URLWithString:@""]
	              placeholderImage:[UIImage imageNamed:@"default_avatar"]];
	[self addSubview:_headerImg];
	[[[[_headerImg.layoutMaker sizeEq:115 h:115] topParent:44] centerXParent:0] install];

	_editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_editBtn setImage:[UIImage imageNamed:@"edit_photo"] forState:UIControlStateNormal];
	[self addSubview:_editBtn];
	[[[[_editBtn.layoutMaker sizeEq:38 h:38] toRightOf:_headerImg offset:-19] below:_headerImg offset:-19] install];


	[_editBtn onClick:self action:@selector(clickEditImage:)];
	return self;
}

- (void)clickEditImage:(id)sender {
	if (self.editBtnClickBlock) {
		_editBtnClickBlock();
	}
}
@end