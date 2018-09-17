//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerPage.h"
#import "Common.h"

@implementation CareerPage {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = [self navigationItem];
	item.title = @"Careers";

	UILabel *lb = self.view.addLabel;
	lb.text = @"Careers Page";
	[lb textColorMain];
	[[[lb.layoutMaker centerParent] sizeFit] install];


}


@end