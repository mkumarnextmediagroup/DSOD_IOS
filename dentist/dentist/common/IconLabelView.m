//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "IconLabelView.h"
#import "Common.h"


@implementation IconLabelView {
	UIImageView *iv;
	UILabel *lb;
}

- (instancetype)init {
	self = [super init];
	iv = [self addImageView];
	lb = [self addLabel];
	[lb textAlignLeft];
	[lb textColorMain];
	[[[[[iv layoutMaker] leftParent:0] centerYParent:0] sizeEq:20 h:20] install];
	[[[[[[lb layoutMaker] leftParent:36] centerYParent:0] rightParent:0] heightEq:22] install];

	[self setBackgroundColor:<#(UIColor *)backgroundColor#>];


	return self;
}

- (UIImageView *)imageView {
	return iv;
}

- (UILabel *)labelView {
	return lb;
}

+ (IconLabelView *)make:(NSString *)icon label:(NSString *)label {
	IconLabelView *v = [IconLabelView new];
	v.imageView.imageName = icon;
	v.labelView.text = label;
	return v;
}

@end