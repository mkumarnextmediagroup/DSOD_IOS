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
#import "UserInfo.h"
#import "Proto.h"


@implementation SlideController {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = UIColor.whiteColor;

	UIView *userView = [self makeUserView];

	UIButton *bCms = [self makeButtonItem:@"General Content" image:@"menu-dso"];
	UIButton *bEdu = [self makeButtonItem:@"Education" image:@"menu-edu"];
	UIButton *bCareer = [self makeButtonItem:@"Careers" image:@"menu-community"];
	UIButton *bEvent = [self makeButtonItem:@"Events" image:@"menu-calendar"];
	UIButton *bUnite = [self makeButtonItem:@"Unite" image:@"menu-unite"];
	UIButton *bProfile = [self makeButtonItem:@"My Profile" image:@"menu-profile"];
	UIButton *bSetting = [self makeButtonItem:@"Settings" image:@"menu-settings"];


	QueueLayout *ql = [QueueLayout new];
	ql.edgeLeft = 18;
	ql.edgeRight = 0;

	[ql add:userView height:115 marginTop:16 + NAVHEIGHT];
	[ql add:[self addLine] height:1 marginTop:16];

	[ql add:bCms height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:bEdu height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:bCareer height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:bEvent height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:bUnite height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:bProfile height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql add:bSetting height:50 marginTop:0];
	[ql add:[self addLine] height:1 marginTop:0];
	[ql install];

	[bProfile onClick:self action:@selector(openProfilePage:)];
	[bCms onClick:self action:@selector(openCMSPage:)];
	[bSetting onClick:self action:@selector(openSettingPage:)];

}

- (UIView *)makeUserView {
	UserInfo *userInfo = [Proto lastUserInfo];
	UIView *v = self.view.addView;
	UIImageView *iv = v.addImageView;
	iv.imageName = @"Img-User-Dentist";
	[iv scaleFillAspect];
	[iv loadUrl:userInfo.portraitUrl placeholderImage:@"Img-User-Dentist"];
	[[[[iv.layoutMaker sizeFit] leftParent:0] topParent:0] install];
	UILabel *lbName = v.addLabel;
	lbName.text = @"John Stewart";
	lbName.font = [Fonts semiBold:15];
	[lbName textColorMain];
	[[[[[lbName layoutMaker] sizeFit] toRightOf:iv offset:16] topParent:6] install];

	UILabel *lbSub = v.addLabel;
	lbSub.text = @"New Jersey, NJ";
	lbSub.font = [Fonts regular:12];
	[lbSub textColorSecondary];
	[[[[[lbSub layoutMaker] sizeFit] toRightOf:iv offset:16] below:lbName offset:5] install];

	return v;
}

- (UIButton *)makeButtonItem:(NSString *)label image:(NSString *)image {
	UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];

	[b setTitle:label forState:UIControlStateNormal];

	[b setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
	[b setTitleColor:Colors.textMain forState:UIControlStateSelected];
	[b setTitleColor:Colors.textMain forState:UIControlStateHighlighted];
	[b setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	[b setImage:[UIImage imageNamed:strBuild(image, @"_light")] forState:UIControlStateSelected];
	b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	b.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	b.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
	b.contentEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
	[b.imageView scaleFit];


	[self.view addSubview:b];
	return b;
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
	view.backgroundColor = Colors.strokes;
	return view;
}

- (IconLabelView *)addMenuItem:(NSString *)icon label:(NSString *)label {
	IconLabelView *v = [IconLabelView make:icon label:label];
	[self.view addSubview:v];
	return v;
}

@end
