//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "EventsPage.h"
#import "Common.h"

@implementation EventsPage {}

- (void)viewDidLoad {
	[super viewDidLoad];
	UINavigationItem *item = [self navigationItem];
	item.title = @"Events";
	UILabel *lb = self.view.addLabel;
	lb.text = @"Events Page";
	[lb textColorMain];
	[[[lb.layoutMaker centerParent] sizeFit] install];
}

@end
