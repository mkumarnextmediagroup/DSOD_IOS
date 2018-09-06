//
// Created by entaoyang on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SlideController.h"
#import "Common.h"
#import "IconLabelView.h"
#import "QueueLayout.h"
#import "ProfileViewController.h"
#import "IIViewDeckController.h"
#import "UIViewController+IIViewDeckAdditions.h"


@implementation SlideController {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = UIColor.whiteColor;

	IconLabelView *v1 = [self addMenuItem:@"icon-99" label:@"General Content"];

//	[[[[[[v1 layoutMaker] topParent:100] leftParent:18] rightParent:0] heightEq:50] install];

	IconLabelView *v2 = [self addMenuItem:@"brain" label:@"Education"];
	IconLabelView *v3 = [self addMenuItem:@"icon-99" label:@"Careers"];
	IconLabelView *v4 = [self addMenuItem:@"a" label:@"Events"];
	IconLabelView *v5 = [self addMenuItem:@"icon-99" label:@"Unite"];
	IconLabelView *v6 = [self addMenuItem:@"icon-99" label:@"My Profile"];
	IconLabelView *v7 = [self addMenuItem:@"setting" label:@"Settings"];

	QueueLayout *ql = [QueueLayout new];
	ql.edgeLeft = 18;
	ql.edgeRight = 0;

	[ql add:v1 height:50 marginTop:100];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v2 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v3 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v4 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v5 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v6 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v7 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql install];

	[v6 onClick:self action:@selector(openProfilePage:)];

}

- (void)openProfilePage:(id)sender {
	NSLog(@"clicked");
	UINavigationController *c = NavPage([ProfileViewController new]);
	IIViewDeckController *dc = self.viewDeckController;
	if (dc != nil) {
		[[dc centerViewController] presentViewController:c animated:YES completion:nil];
	}
}

- (UIView *)addLine {
	UIView *view = self.view.addView;
	view.backgroundColor = Colors.secondary;
	return view;
}

- (IconLabelView *)addMenuItem:(NSString *)icon label:(NSString *)label {
	IconLabelView *v = [IconLabelView make:icon label:label];
	[self.view addSubview:v];
	return v;
}

@end