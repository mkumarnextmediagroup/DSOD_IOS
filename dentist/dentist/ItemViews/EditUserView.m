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
	noticeLab.text = @"Profile photo";
	noticeLab.textAlignment = NSTextAlignmentCenter;
	[self addSubview:noticeLab];
	[[[[noticeLab.layoutMaker sizeEq:100 h:20] topParent:22] centerXParent:0] install];

	_headerImg = [UIImageView new];
	_headerImg.imageName = @"headerImage";

	_headerImg.imageName = @"default_avatar";
	[self addSubview:_headerImg];
	[[[[_headerImg.layoutMaker sizeEq:115 h:115] topParent:44] centerXParent:0] install];

	_editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_editBtn setImage:[UIImage imageNamed:@"edit_photo"] forState:UIControlStateNormal];
	[self addSubview:_editBtn];
	[[[[_editBtn.layoutMaker sizeEq:38 h:38] toRightOf:_headerImg offset:-19] below:_headerImg offset:-19] install];


	_percentageLab = [[UILabel alloc] init];
	_percentageLab.textColor = Colors.textMain;
	_percentageLab.font = [Fonts regular:12];
	_percentageLab.text = @"Profile 100% complete";


	_percentageLab.textAlignment = NSTextAlignmentCenter;
	[self addSubview:_percentageLab];
	[[[[_percentageLab.layoutMaker sizeFit] topParent:200] centerXParent:0] install];


	_pView = [[UIProgressView alloc] init];
	_pView.progressTintColor = rgb255(135, 154, 168);
	_pView.trackTintColor = rgb255(233, 237, 241);

	//set progress
	_pView.progress = [self roundFloat:_percent];
	_pView.progressViewStyle = UIProgressViewStyleDefault;
	[self addSubview:_pView];
	[[[[_pView.layoutMaker sizeEq:SCREENWIDTH - 19.2 * 2 h:2] topParent:222] centerXParent:0] install];


	return self;
}


- (float)roundFloat:(float)price {
	return roundf(price * 100) / 100;
}

- (void)reset:(float)percent {
	float p = [self roundFloat:percent];
	_pView.progress = p;
	NSString *percentStr = [NSString stringWithFormat:@"%i", (int) (p * 100)];
	_percentageLab.text = strBuild(@"Profile ", percentStr, @"%", @" complete");
}

@end
