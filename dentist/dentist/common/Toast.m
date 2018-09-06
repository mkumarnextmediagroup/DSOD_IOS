//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Toast.h"
#import "Fonts.h"
#import "Common.h"


@implementation Toast {

}

- (instancetype)init {
	self = [super init];

	self.y = SCREENHEIGHT / 2;
	self.font = [Fonts regular:10];
	self.backColor = rgba255(94, 110, 122, 100);
	self.textColor = [UIColor whiteColor];

	return self;
}
@end