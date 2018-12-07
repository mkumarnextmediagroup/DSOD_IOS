//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIViewController+myextend.h"
#import "Common.h"
#import "IdName.h"
#import "SearchPage.h"
#import "dentist-Swift.h"

@implementation UIViewController (myextend)


- (UINavigationBar *)navBar {
	if (self.navigationController != nil) {
		return self.navigationController.navigationBar;
	}
	return nil;
}

- (void)tabItem:(NSString *)title imageName:(NSString *)imageName {
	UITabBarItem *item = self.tabBarItem;
	item.title = title;
	item.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	item.selectedImage = [[UIImage imageNamed:strBuild(imageName, @"-light")] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

- (void)alertMsg:(nonnull NSString *)msg onOK:(void (^ __nullable)(void))onOK {
	[self alertOK:nil msg:msg okText:nil onOK:onOK];
}


- (UIBarButtonItem *)navBarText:(NSString *)text target:(nullable id)target action:(SEL)action {
	UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:target action:action];
    if ([text isEqualToString:@"Search"]) {
        [bi setTitleTextAttributes:@{NSForegroundColorAttributeName: rgb255(211, 220, 227), NSFontAttributeName: [Fonts semiBold:15]} forState:UIControlStateNormal];
    }else
    {
        [bi setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [Fonts semiBold:15]} forState:UIControlStateNormal];
    }
	return bi;
}

- (UIBarButtonItem *)navBarImage:(NSString *)imageName target:(nullable id)target action:(SEL)action {
	UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:target action:action];
	return bi;
}

- (UIBarButtonItem *)navBarBack:(nullable id)target action:(SEL)action {
	return [self navBarImage:@"back_arrow" target:target action:action];
}

- (UIBarButtonItem *)backBarButtonClose {
	return [self navBarImage:@"back_arrow" target:self action:@selector(_closePage:)];
}

- (void)_closePage:(id)sender {
	[self popPage];
}

- (void)openPage:(UIViewController *)page {
	[self presentViewController:page animated:YES completion:nil];
}

- (void)pushPage:(UIViewController *)page {
	if ([self isKindOfClass:[UINavigationController class]]) {
		UINavigationController *c = (UINavigationController *) self;
		[c pushViewController:page animated:YES];
		return;
	}
	UINavigationController *c = self.navigationController;
	if (c != nil) {
		[c pushViewController:page animated:YES];
		return;
	}
	[self presentViewController:page animated:YES completion:nil];
}

- (void)popPage {
	[self dismiss];
}

- (void)dismiss {
	if (self.navigationController != nil) {
		[self.navigationController popViewControllerAnimated:YES];
		return;
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeKeyboardWhenClickSelfView {
	[self.view onClickView:self action:@selector(_onClickControllerView:)];
}


- (void)_onClickControllerView:(UIView *)sender {
	[self.view endEditing:YES];
}


- (void)showLoading{
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = argbHex(0xAA000000);
    hud.mode = MBProgressHUDModeIndeterminate;
    
}

- (void)hideLoading{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showIndicator {
    [self showLoading];
}

- (void)hideIndicator {
    [self hideLoading];
}

- (void)selectIdName:(NSString *)title array:(NSArray<IdName *> *)array selectedId:(NSString *)selectedId result:(void (^)(IdName *))result {
	SearchPage *c = [SearchPage new];
	c.titleText = title;
	c.withIndexBar = YES;
	[c setItemsPlain:array displayBlock:^(NSObject *item) {
		IdName *s = (IdName *) item;
		return s.name;
	}];

	if (selectedId != nil) {
		for (IdName *item in array) {
			if ([item.id isEqualToString:selectedId]) {
				c.checkedItem = item;
				break;
			}
		}
	}
	c.onResult = ^(NSObject *item) {
		result((IdName *) item);
	};
	[self pushPage:c];
}

@end
