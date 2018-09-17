//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TestPage.h"
#import "Common.h"


@implementation TestPage {

}
- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [self backBarButtonClose];
	UILabel *lb = [self.view addLabel];
	lb.backgroundColor = UIColor.greenColor;
	lb.text = @"Hello";

	[[[[[lb.layoutMaker heightEq:120] topParent:0] leftParent:0] rightParent:0] install];
}


@end