//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseItemView.h"
#import "Common.h"


@implementation BaseItemView {

}
- (instancetype)init {
	self = [super init];
	self.layoutParam.height = 76;
	return self;
}

- (void)resetLayout {

}

- (UIImageView *)addArrowView {
	UIImageView *iconView = self.addImageView;
	iconView.imageName = @"arrow_small";
	[iconView alignCenter];
	return iconView;
}
@end