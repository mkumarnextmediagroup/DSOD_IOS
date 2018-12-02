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
#import "CareerExplorePage.h"
#import "CareerFindJobViewController.h"
#import "CareerMyJobViewController.h"
#import "CareerAlertsViewController.h"
#import "CareerMoreViewController.h"
#import "EventsPage.h"
#import "UnitePage.h"
#import "CmsBookmarkController.h"
#import "CmsDownloadsController.h"
#import "CmsForYouPage.h"
#import "CmsSearchPage.h"
#import "CmsCategoryPage.h"


@implementation SlideController {
	NSArray *items;
	UIImageView *imageView;
	UILabel *lbName;
	UILabel *lbSub;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;

	UIView *userView = [self makeUserView];

	items = @[
			[self makeSlideItem:@"Browse Content" image:@"menu-dso"],
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
    [ql add:[self addLine] height:1 marginTop:NAVHEIGHT];
    [ql add:userView height:115 marginTop:16];
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
}

- (UIBarButtonItem *)menuButton {
	return [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenu:)];
}

- (UIViewController *)onMakePage:(NSString *)title {
	if ([@"Browse Content" isEqualToString:title]) {
		CmsForYouPage *forYouPage = [CmsForYouPage new];
        UINavigationController *ncForYou = NavPage(forYouPage);
		[ncForYou tabItem:@"For you" imageName:@"foryou"];
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
		[ncBook tabItem:@"Bookmarks" imageName:@"bookmark"];
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
        CareerExplorePage *explorePage = [CareerExplorePage new];
        UINavigationController *ncExplore = NavPage(explorePage);
        [ncExplore tabItem:@"Explore" imageName:@"explore"];
        explorePage.navigationItem.leftBarButtonItem = [self menuButton];
        
        CareerFindJobViewController *findJob = [CareerFindJobViewController new];
        UINavigationController *ncFindJob = NavPage(findJob);
        [ncFindJob tabItem:@"Find Job" imageName:@"findJob"];
        findJob.navigationItem.leftBarButtonItem = [self menuButton];
        
        CareerMyJobViewController *myJob = [CareerMyJobViewController new];
        UINavigationController *ncMyJob = NavPage(myJob);
        [ncMyJob tabItem:@"My Jobs" imageName:@"myJobs"];
        myJob.navigationItem.leftBarButtonItem = [self menuButton];
        
        CareerAlertsViewController *alert = [CareerAlertsViewController new];
        UINavigationController *ncAlert = NavPage(alert);
        [ncAlert tabItem:@"Alerts" imageName:@"alert"];
        alert.navigationItem.leftBarButtonItem = [self menuButton];
        
        CareerMoreViewController *more = [CareerMoreViewController new];
        more.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        UINavigationController *ncMore = NavPage(more);
        ncMore.view.backgroundColor = [UIColor clearColor];
        [ncMore tabItem:@"More" imageName:@"more"];
        more.navigationItem.leftBarButtonItem = [self menuButton];
        
//        return TabPage(@[ncExplore, ncFindJob, ncMyJob, ncAlert, ncMore]);
        return myTab([EventsPage new]);

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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UserInfo *userInfo = [Proto lastUserInfo];
	[imageView loadUrl:userInfo.portraitUrlFull placeholderImage:@"user_img"];
	lbName.text = userInfo.fullName;
	lbSub.text = @"";
	if (userInfo.practiceAddress) {
		NSString *city = userInfo.practiceAddress.city;
		NSString *st = userInfo.practiceAddress.stateLabel;
		if (city && city.length > 0) {
			if (st && st.length > 0) {
				lbSub.text = strBuild(userInfo.practiceAddress.city, @", ", userInfo.practiceAddress.stateLabel);
			} else {
				lbSub.text = userInfo.practiceAddress.city;
			}
		} else if (st && st.length > 0) {
			lbSub.text = userInfo.practiceAddress.stateLabel;
		}
	}
}


- (UIView *)makeUserView {
	UserInfo *userInfo = [Proto lastUserInfo];
	UIView *v = self.view.addView;
	imageView = v.addImageView;
	imageView.imageName = @"Img-User-Dentist";
	[imageView scaleFill];
	[imageView loadUrl:userInfo.portraitUrlFull placeholderImage:@"Img-User-Dentist"];
	[[[[imageView.layoutMaker sizeEq:115 h:115] leftParent:0] topParent:0] install];
	lbName = v.addLabel;
	lbName.text = @"";
	lbName.font = [Fonts semiBold:15];
	[lbName textColorMain];
	[[[[[[lbName layoutMaker] heightEq:22] toRightOf:imageView offset:16] topParent:6] rightParent:-10] install];

	lbSub = v.addLabel;
	lbSub.text = @"";
	lbSub.font = [Fonts regular:12];
	[lbSub textColorSecondary];
	[[[[[[lbSub layoutMaker] heightEq:16] toRightOf:imageView offset:16] below:lbName offset:5] rightParent:-10] install];

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
    NSString *title=[sender titleForState:UIControlStateNormal];
	UIViewController *c = [self onMakePage:title];
    if ([@"Browse Content" isEqualToString:title]){
        [self openCenterPage:c hasNav:NO];
    }else if ([@"Careers" isEqualToString:title]){
        [self openCenterPage:c hasNav:NO];
    }else
    {
        [self openCenterPage:c hasNav:YES];
    }
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

- (void)openCenterPage:(UIViewController *)page hasNav:(BOOL)hasNav {
    if (hasNav) {
        UINavigationController *c = NavPage(page);
        page.navigationItem.leftBarButtonItem = [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenu:)];
        IIViewDeckController *dc = self.viewDeckController;
        if (dc != nil) {
            [dc closeSide:YES];
            dc.centerViewController = c;
        }
    }else{
        IIViewDeckController *dc = self.viewDeckController;
        if (dc != nil) {
            [dc closeSide:YES];
            dc.centerViewController = page;
        }
    }
    
}


- (UIView *)addLine {
	UIView *view = self.view.addView;
	view.backgroundColor = Colors.strokes;
	return view;
}

@end
