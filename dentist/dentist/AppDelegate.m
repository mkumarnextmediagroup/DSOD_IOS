//
//  AppDelegate.m
//  dentist
//
//  Created by yet on 2018/8/15.
//  Copyright © 2018年 nextmedia.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "ProfileViewController.h"
#import "BaseNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	//notificate for the internet
	// Override point for customization after application launch.
	self.window = [[UIWindow alloc] init];
	self.window.frame = [[UIScreen mainScreen] bounds];
	self.window.backgroundColor = UIColor.whiteColor;
    LoginController *c = [[LoginController alloc] init];
//    self.window.rootViewController = lc;
    BaseNavController *nc = [BaseNavController new];
//    ProfileViewController *c = [ProfileViewController new];
    [nc pushViewController:c animated:NO];
    self.window.rootViewController = nc ;
	[self.window makeKeyAndVisible];
	return YES;
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
