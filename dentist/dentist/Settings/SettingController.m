//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SettingController.h"
#import "IIViewDeckController.h"
#import "Proto.h"
#import "AppDelegate.h"


@implementation SettingController {

}

- (void)viewDidLoad {
	[super viewDidLoad];

	UILabel *lb = self.view.addLabel;
	lb.text = @"Setting Page";
	[lb textColorMain];

	[[[lb.layoutMaker centerParent] sizeFit] install];

	UINavigationItem *item = [self navigationItem];
	item.title = @"SETTING";
	item.rightBarButtonItems = @[
        [self navBarText:@"Logout" target:self action:@selector(onClickLogout:)]
	];


}

- (void)onClickLogout:(id)sender {
	[Proto logout];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate switchToWelcomePage];
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    [linkedIn logout];
}

- (void)onClickEdit:(id)sender {
}
@end
