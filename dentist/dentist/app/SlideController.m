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
#import "AppDelegate.h"
#import "CmsMainController.h"
#import "SettingController.h"


@implementation SlideController {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = UIColor.whiteColor;

	IconLabelView *vCMS = [self addMenuItem:@"icon-99" label:@"General Content"];
	IconLabelView *v2 = [self addMenuItem:@"brain" label:@"Education"];
	IconLabelView *v3 = [self addMenuItem:@"icon-99" label:@"Careers"];
	IconLabelView *v4 = [self addMenuItem:@"a" label:@"Events"];
	IconLabelView *v5 = [self addMenuItem:@"icon-99" label:@"Unite"];
	IconLabelView *vProfile = [self addMenuItem:@"icon-99" label:@"My Profile"];
	IconLabelView *vSetting = [self addMenuItem:@"setting" label:@"Settings"];

	QueueLayout *ql = [QueueLayout new];
	ql.edgeLeft = 18;
	ql.edgeRight = 0;

	[ql add:vCMS height:50 marginTop:100];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v2 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v3 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v4 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:v5 height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:vProfile height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:vSetting height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql install];

	[vProfile onClick:self action:@selector(openProfilePage:)];
	[vCMS onClick:self action:@selector(openCMSPage:)];
	[vSetting onClick:self action:@selector(openSettingPage:)];

}

- (void)openSettingPage:(id)sender {
	[self openCenterPage:[SettingController new]];
}

- (void)openProfilePage:(id)sender {
	[self openCenterPage:[ProfileViewController new]];
}

- (void)openCMSPage:(id)sender {
	[self openCenterPage:[CmsMainController new]];
}

- (void)openCenterPage:(UIViewController *)page {
	UINavigationController *c = NavPage(page);
	page.navigationItem.leftBarButtonItem = [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenu:)];
	IIViewDeckController *dc = self.viewDeckController;
	if (dc != nil) {
		[dc closeSide:YES];
		dc.centerViewController = c;
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