//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIViewController+myextend.h"
#import "Common.h"


@implementation UIViewController (myextend)




- (void)tabItem:(NSString *)title imageName:(NSString *)imageName {
	UITabBarItem *item = self.tabBarItem;
	item.title = title;
	item.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	item.selectedImage = [[UIImage imageNamed:strBuild(imageName, @"_light")] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (void)alertOK:(NSString *)title msg:(NSString *)msg okText:(NSString *)okText onOK:(void (^ __nullable)(void))onOK {
	UIAlertController *c = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
	NSString *text = okText;
	if (text == nil) {
		text = localStr(@"ok");
	}
	UIAlertAction *ac = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		if (onOK != nil) {
			onOK();
		}
	}];
	[c addAction:ac];
	[self presentViewController:c animated:YES completion:nil];

}

- (void)alertConfirm:(NSString *)title msg:(NSString *)msg {

}


@end