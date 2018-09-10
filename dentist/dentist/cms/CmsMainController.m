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
	c.withIndexBar = NO;
	NSArray *arr = @[@"Alibaba", @"Aha", @"Alibaba1", @"Aha1", @"Alibaba2", @"Aha2", @"Alibaba3", @"Aha3", @"Alibaba4", @"Aha4", @"Alibaba5", @"Aha5", @"Alibaba6", @"Aha6", @"Cool", @"Yang", @"YangEntao", @"Yang1", @"YangEntao1", @"Yang2", @"YangEntao2", @"Yang3", @"YangEntao3", @"Yang4", @"YangEntao4", @"Yang5", @"YangEntao5", @"Yang6", @"YangEntao6"];
	NSArray *arrSorted = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
		return [a compare:b];
	}];
	[c setItems:arrSorted groupBy:^(NSObject *item) {
		NSString *s = (NSString *) item;
		return [s substringToIndex:1];
	}];
//	c.checkedItem = @"Yang";
	[self pushPage:c];


}
@end