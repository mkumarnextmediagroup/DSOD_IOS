//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "LinearPage.h"
#import "Common.h"
#import "LinearView.h"
#import "LinearVerView.h"


@implementation LinearPage {
}

- (void)clickHello:(id)sender {
//	lv.subviews[0].layoutParam.height = 200;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [self navBarText:@"Helo" target:self action:@selector(clickHello:)];
	_linearView = [LinearView new];
	[self.contentView addSubview:_linearView];
	[[[[[_linearView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
}

@end
