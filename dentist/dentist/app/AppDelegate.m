//
//  AppDelegate.m
//  dentist
//
//  Created by yet on 2018/8/15.
//  Copyright © 2018年 nextmedia.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "WelcomController.h"
#import "UIViewController+myextend.h"
#import "IIViewDeckController.h"
#import "SlideController.h"
#import "Proto.h"
#import "Common.h"
#import "SliderListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


+ (AppDelegate *)instance {
	AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
	return delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


	//notificate for the internet
	// Override point for customization after application launch.
	self.window = [[UIWindow alloc] init];
	self.window.frame = [[UIScreen mainScreen] bounds];
	self.window.backgroundColor = UIColor.whiteColor;
	[self configGlobalStyle];

	if (Proto.isLogined) {
		self.window.rootViewController = [self makeMainPage];
	} else {
		self.window.rootViewController = [WelcomController new];
	}

	[self.window makeKeyAndVisible];
	return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.supportRatate) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)switchToMainPage {
	self.window.rootViewController = [self makeMainPage];
}

- (void)switchToWelcomePage {
	self.window.rootViewController = [WelcomController new];
}

- (UIViewController *)makeMainPage {
	SlideController *sc = [SlideController new];
	sc.preferredContentSize = makeSize(SCREENWIDTH - 90, SCREENHEIGHT);
	UINavigationController *snav = NavPage(sc);
    sc.navigationItem.leftBarButtonItem = [sc navBarImage:@"menu" target:self action:@selector(closeMenu:)];
    snav.navigationBar.tintColor = Colors.primary;
	snav.navigationBar.barTintColor = UIColor.whiteColor;

    SliderListViewController * slider = [SliderListViewController new];
    slider.preferredContentSize = makeSize(SCREENWIDTH - 132, SCREENHEIGHT);
    
	UIViewController *centerPage = [sc onMakePage:@"Browse Content"];
	IIViewDeckController *deck = [[IIViewDeckController alloc] initWithCenterViewController:centerPage leftViewController:snav rightViewController:slider];
	return deck;
}

- (UIViewController *)careersPage {
    if ([self.window.rootViewController isKindOfClass:[IIViewDeckController class]]) {
        IIViewDeckController *tc = (IIViewDeckController *) self.window.rootViewController;
        return tc.centerViewController;
    }
    return nil;
}

- (void)closeMenu:(id)sender {
	if ([self.window.rootViewController isKindOfClass:[IIViewDeckController class]]) {
        IIViewDeckController *tc = (IIViewDeckController *) self.window.rootViewController;
        [tc closeSide:YES];
	}
}

- (void)onOpenMenu:(id)sender {
	if ([self.window.rootViewController isKindOfClass:[IIViewDeckController class]]) {
		IIViewDeckController *tc = (IIViewDeckController *) self.window.rootViewController;
		[tc openSide:IIViewDeckSideLeft animated:YES];
	}
}

- (void)onOpenMenuAnoSide:(id)sender {
    if ([self.window.rootViewController isKindOfClass:[IIViewDeckController class]]) {
        IIViewDeckController *tc = (IIViewDeckController *) self.window.rootViewController;
        [tc openSide:IIViewDeckSideRight animated:YES];
    }
}

- (void)configGlobalStyle {
	[[UITabBarItem appearance] setTitleTextAttributes:@{
			NSForegroundColorAttributeName: Colors.textAlternate,
			NSFontAttributeName: [Fonts regular:10]
	}                                        forState:UIControlStateNormal];
	[[UITabBarItem appearance] setTitleTextAttributes:@{
			NSForegroundColorAttributeName: Colors.textMain, NSFontAttributeName: [Fonts regular:10]
	}                                        forState:UIControlStateSelected];

	[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
	[[UITabBar appearance] setTintColor:Colors.primary];

	[[UINavigationBar appearance] setBarTintColor:Colors.bgNavBarColor];
	[[UINavigationBar appearance] setTintColor:UIColor.whiteColor];
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [Fonts semiBold:15]}];

	[[UINavigationBar appearance] setShadowImage:[UIImage new]];

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
	return YES;
}

//- (void)AFNetWorkReachabilityStatus {
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"未识别的网络");
//                [self presentTheNoInternetPage];
//                break;
//
//            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"不可达的网络(未连接)");
//                [self presentTheNoInternetPage];
//                break;
//
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"2G,3G,4G...的网络");
//                break;
//
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"wifi的网络");
//                break;
//            default:
//                break;
//        }
//    }];
//    [manager startMonitoring];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
