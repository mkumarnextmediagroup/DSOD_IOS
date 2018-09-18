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
#import "SettingController.h"
#import "UserInfo.h"
#import "Proto.h"
#import "SlideItem.h"
#import "EducationPage.h"
#import "CareerPage.h"
#import "EventsPage.h"
#import "UnitePage.h"
#import "CmsBookmarkController.h"
#import "CmsDownloadsController.h"
#import "CmsForYouPage.h"
#import "CmsSearchPage.h"
#import "CmsCategoryPage.h"


@implementation SlideController {
	NSArray *items;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;

	UIView *userView = [self makeUserView];

	items = @[
			[self makeSlideItem:@"General Content" image:@"menu-dso"],
			[self makeSlideItem:@"Education" image:@"menu-edu"],
			[self makeSlideItem:@"Careers" image:@"menu-community"],
			[self makeSlideItem:@"Events" image:@"menu-calendar"],
			[self makeSlideItem:@"Unite" image:@"menu-unite"],
			[self makeSlideItem:@"My Profile" image:@"menu-profile"],
			[self makeSlideItem:@"Settings" image:@"menu-settings"],
	];

	QueueLayout *ql = [QueueLayout new];
	ql.edgeLeft = 18;
	ql.edgeRight = 0;
	[ql add:userView height:115 marginTop:16 + NAVHEIGHT];
	[ql add:[self addLine] height:1 marginTop:16];

	for (SlideItem *item in items) {
		UIButton *b = [self makeButtonItem:item.title image:item.image];
		[ql add:b height:50 marginTop:0];
		[ql add:[self addLine] height:1 marginTop:0];
		[b onClick:self action:@selector(clickSlideItem:)];
		item.button = b;
	}
	[ql install];

	[self selectButton:nil];

	Log(@"View Did Load ");
}

- (UIBarButtonItem *)menuButton {
	return [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenu:)];
}

- (UIViewController *)onMakePage:(NSString *)title {
	if ([@"General Content" isEqualToString:title]) {
		CmsForYouPage *forYouPage = [CmsForYouPage new];
		UINavigationController *ncForYou = NavPage(forYouPage);
		[ncForYou tabItem:@"Home" imageName:@"home"];
		forYouPage.navigationItem.leftBarButtonItem = [self menuButton];

		CmsSearchPage *cSearch = [CmsSearchPage new];
		UINavigationController *ncSearch = NavPage(cSearch);
		[ncSearch tabItem:@"Search" imageName:@"search"];
		cSearch.navigationItem.leftBarButtonItem = [self menuButton];

		CmsCategoryPage *catPage = [CmsCategoryPage new];
		UINavigationController *ncCat = NavPage(catPage);
		[ncCat tabItem:@"Category" imageName:@"category"];
		catPage.navigationItem.leftBarButtonItem = [self menuButton];

		CmsBookmarkController *bookPage = [CmsBookmarkController new];
		UINavigationController *ncBook = NavPage(bookPage);
		[ncBook tabItem:@"Bookmark" imageName:@"bookmark"];
		bookPage.navigationItem.leftBarButtonItem = [self menuButton];

		CmsDownloadsController *downPage = [CmsDownloadsController new];
		UINavigationController *ncDown = NavPage(downPage);
		[ncDown tabItem:@"Downloads" imageName:@"download"];
		downPage.navigationItem.leftBarButtonItem = [self menuButton];

		return TabPage(@[ncForYou, ncSearch, ncCat, ncBook, ncDown]);
	}
	if ([@"Education" isEqualToString:title]) {
		return [EducationPage new];
	}
	if ([@"Careers" isEqualToString:title]) {
		return [CareerPage new];
	}
	if ([@"Events" isEqualToString:title]) {
		return [EventsPage new];
	}
	if ([@"Unite" isEqualToString:title]) {
		return [UnitePage new];
	}
	if ([@"My Profile" isEqualToString:title]) {
		return [ProfileViewController new];
	}
	if ([@"Settings" isEqualToString:title]) {
		return [SettingController new];
	}
	return nil;
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
	b.titleLabel.font = [Fonts medium:15];
	[b setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
	[b setTitleColor:UIColor.blackColor forState:UIControlStateSelected];
	[b setTitleColor:UIColor.blackColor forState:UIControlStateHighlighted];
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

- (SlideItem *)makeSlideItem:(NSString *)title image:(NSString *)image {
	SlideItem *item = [SlideItem new];
	item.title = title;
	item.image = image;
	return item;
}

- (void)clickSlideItem:(UIButton *)sender {
	[self selectButton:sender];
	UIViewController *c = [self onMakePage:[sender titleForState:UIControlStateNormal]];
	[self openCenterPage:c];
}

- (void)selectButton:(UIButton *)b {
	if (b == nil) {
		SlideItem *first = items[0];
		b = first.button;
	}
	for (SlideItem *item in items) {
		item.button.selected = (item.button == b);
		if (item.button.isSelected) {
			item.button.titleLabel.font = [Fonts semiBold:15];
		} else {
			item.button.titleLabel.font = [Fonts medium:15];
		}
	}
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

@end
