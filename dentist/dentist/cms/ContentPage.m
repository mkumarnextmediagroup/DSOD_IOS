//
// Created by entaoyang on 2018/9/23.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ContentPage.h"
#import "Common.h"


@implementation ContentPage {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	_contentView = [self.view addView];
	CGFloat topOffset = 0;
	CGFloat bottomOffset = 0;
	if (self.navigationController) {
		topOffset = NAVHEIGHT;
	}
	if (self.tabBarController) {
		bottomOffset = TABLEBAR_HEIGHT;
	}
	[[[[[_contentView.layoutMaker leftParent:0] rightParent:0] topParent:topOffset] bottomParent:-bottomOffset] install];
}
@end