//
// Created by entaoyang@163.com on 2018/9/3.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TitlePage.h"


@implementation TitlePage {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationBar *bar = self.navBar;
	if (bar != nil) {
		bar.barTintColor = Colors.bgNavBarColor;
		bar.tintColor = UIColor.whiteColor;
		[bar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [Fonts semiBold:15]}];
	}

}

- (UINavigationBar *)navBar {
	if (self.navigationController != nil) {
		return self.navigationController.navigationBar;
	}
	return nil;
}

- (UIBarButtonItem *)navBarText:(NSString *)text action:(SEL)action {
	UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:self action:action];
	[bi setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [Fonts semiBold:15]} forState:UIControlStateNormal];
	return bi;
}

- (UIBarButtonItem *)navBarImage:(NSString *)imageName action:(SEL)action {
	UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:action];
	return bi;
}


@end