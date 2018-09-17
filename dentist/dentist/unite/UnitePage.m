//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UnitePage.h"
#import "Common.h"

@implementation UnitePage {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = [self navigationItem];
	item.title = @"Unite";

	UILabel *lb = self.view.addLabel;
	lb.text = @"Unite Page";
	[lb textColorMain];
	[[[lb.layoutMaker centerParent] sizeFit] install];


}


@end