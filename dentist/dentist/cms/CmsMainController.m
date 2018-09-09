//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsMainController.h"
#import "IIViewDeckController.h"
#import "TestPage.h"
#import "ScrollPage.h"
#import "TestScrollPage.h"
#import "ProfileEditPage.h"
#import "SearchPage.h"


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
	SearchPage *c = [SearchPage new];
	NSArray *arr = @[@"Alibaba", @"Aha", @"Alibaba", @"Aha", @"Alibaba", @"Aha", @"Alibaba", @"Aha", @"Alibaba", @"Aha", @"Alibaba", @"Aha", @"Alibaba", @"Aha", @"Cool", @"Yang", @"YangEntao", @"Yang", @"YangEntao", @"Yang", @"YangEntao", @"Yang", @"YangEntao", @"Yang", @"YangEntao", @"Yang", @"YangEntao", @"Yang", @"YangEntao"];
	[c setItems:arr groupBy:^(NSObject *item) {
		NSString *s = (NSString *) item;
		return [s substringToIndex:1];
	}];
//	c.checkedItem = @"Yang";
	[self pushPage:c];


}
@end