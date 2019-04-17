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
@import Firebase;
@import UserNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

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
        [self switchToMainPage];
	} else {
        [self switchToWelcomePage];
	}
    // 一次性代码
    [self projectOnceCode];
    
    // 开启网络监听
    [[DentistNetworkReachabilityManager shareManager] monitorNetworkStatus];
    
    // 开启等待下载的任务
    [[DentistDownloadManager shareManager] openDownloadTask];

	[self.window makeKeyAndVisible];
    [FIRApp configure];
//    [FIRAnalytics setAnalyticsCollectionEnabled:YES];
    [FIRMessaging messaging].delegate = self;
    
    [self registerforRemoteNotifications];
    
	return YES;
}

- (void)registerforRemoteNotifications {
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
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

-(void)switchToLoginPage{
    if(![self.window.rootViewController isKindOfClass:WelcomController.class]){
        WelcomController *welcomeVc = [WelcomController new];
        self.window.rootViewController = welcomeVc;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoginController *loginVc = [LoginController new];
            [welcomeVc openPage:loginVc];
        });
    }
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
	IIViewDeckController *deck = [[IIViewDeckController alloc] initWithCenterViewController:centerPage leftViewController:snav rightViewController:nil];
	return deck;
}

- (UIViewController *)careersPage {
    if ([self.window.rootViewController isKindOfClass:[IIViewDeckController class]]) {
        IIViewDeckController *tc = (IIViewDeckController *) self.window.rootViewController;
        return tc.centerViewController;
    }
    return nil;
}

- (UIViewController *)mainLeftPage {
    if ([self.window.rootViewController isKindOfClass:[IIViewDeckController class]]) {
        IIViewDeckController *tc = (IIViewDeckController *) self.window.rootViewController;
        if([tc.leftViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController *snav=(UINavigationController *)tc.leftViewController;
            return snav.topViewController;
        }else{
          return tc.leftViewController;
        }
        
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
			NSForegroundColorAttributeName: Colors.textDisabled, NSFontAttributeName: [Fonts regular:10]
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
    // 实现如下代码，才能使程序处于后台时被杀死，调用applicationWillTerminate:方法
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(){}];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [[[UIApplication sharedApplication]keyWindow] endEditing:YES];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DentistDownloadManager shareManager] updateDownloadingTaskState];
}

// 应用处于后台，所有下载任务完成调用
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    _backgroundSessionCompletionHandler = completionHandler;
}


// 一次性代码
- (void)projectOnceCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"DentistProjectOnceKey"]) {
        // 初始化下载最大并发数为1
        [defaults setInteger:3 forKey:DentistDownloadMaxConcurrentCountKey];
        // 初始化不允许蜂窝网络下载
        [defaults setBool:NO forKey:DentistDownloadAllowsCellularAccessKey];
        [defaults setBool:YES forKey:@"DentistProjectOnceKey"];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}
// [END receive_message]

// [START ios_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}

// [END ios_10_message_handling]

// [START refresh_token]
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    
    // With swizzling disabled you must set the APNs device token here.
    // [FIRMessaging messaging].APNSToken = deviceToken;
}

@end
