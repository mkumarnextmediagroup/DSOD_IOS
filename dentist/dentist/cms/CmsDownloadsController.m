//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsDownloadsController.h"


@implementation CmsDownloadsController {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	UILabel *lb = self.view.addLabel;
	lb.text = @"Downloads Page";
	[lb textColorMain];

	[[[lb.layoutMaker centerParent] sizeFit] install];

	UINavigationItem *item = [self navigationItem];
	item.title = @"DSODENTIST";
	item.leftBarButtonItem = [self navBarImage:@"menu" action:@selector(onClickEdit:)];
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" action:@selector(onClickEdit:)]
	];
}
@end