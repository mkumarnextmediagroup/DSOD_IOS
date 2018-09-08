//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "GroupItem.h"


@implementation GroupItem {
	NSMutableArray *_children;
}

- (instancetype)init {
	self = [super init];
	_children = [NSMutableArray arrayWithCapacity:8];
	return self;
}

- (NSMutableArray *)children {
	return _children;
};
@end