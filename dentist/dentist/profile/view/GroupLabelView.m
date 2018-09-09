//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "GroupLabelView.h"
#import "Common.h"


@implementation GroupLabelView {

}
- (instancetype)init {
	self = [super init];
	[self textColorSecondary];
	self.font = [Fonts regular:12];
	self.backgroundColor = UIColor.clearColor;
	return self;
}
@end