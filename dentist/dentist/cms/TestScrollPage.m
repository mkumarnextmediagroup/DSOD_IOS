//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TestScrollPage.h"
#import "Common.h"


@implementation TestScrollPage {
	UILabel *lb;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [self navBarText:@"Test" target:self action:@selector(clickTest:)];

}

- (UIView *)onCreateContent {
	lb = [UILabel new];
	lb.backgroundColor = UIColor.blueColor;
	lb.text = @"=====================";
	[self.contentView addSubview:lb];
	[[[[[[lb layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:1200] install];

	return lb;
}


- (void)clickTest:(id)sender {
	NSLog(@"click ");
	[lb removeFromSuperview];
}

@end