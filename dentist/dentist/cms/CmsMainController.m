//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsMainController.h"
#import "SearchPage.h"
#import "Common.h"
#import "PickerPage.h"
#import "NSDate+myextend.h"


@implementation CmsMainController {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	UILabel *lb = self.view.addLabel;
	lb.text = @"CMS Page";
	[lb textColorMain];

	[[[lb.layoutMaker centerParent] sizeFit] install];

	UINavigationItem *item = [self navigationItem];
	item.title = @"DSODENTIST";
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" target:self action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" target:self action:@selector(onClickEdit:)]
	];


}


- (void)onClickEdit:(id)sender {
//	UIViewController *c = [TestPage new];

	PickerPage *c = [PickerPage pickYearMonthFromNowDownTo:1930];

	[self.navigationController presentViewController:c animated:YES completion:nil];


}
@end