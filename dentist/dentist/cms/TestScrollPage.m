//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TestScrollPage.h"
#import "Common.h"


@implementation TestScrollPage {

}

- (UIView *)onCreateContent {
	UILabel *lb = [UILabel new];
	lb.backgroundColor = UIColor.blueColor;
	lb.text = @"=====================";
	[self.contentView addSubview:lb];
	[[[[[[lb layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:200] install];

	return lb;
}

@end