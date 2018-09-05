//
// Created by entaoyang on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SlideController.h"
#import "Common.h"


@implementation SlideController {

}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = Colors.secondary;

	UILabel *lb = [self.view addLabel];
	lb.text = @"SlideMenu";
	[lb textColorMain];

	[[[lb.layoutMaker centerParent] sizeFit] install];
}
@end