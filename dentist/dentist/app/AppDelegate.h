//
//  AppDelegate.h
//  dentist
//
//  Created by yet on 2018/8/15.
//  Copyright © 2018年 nextmedia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) UIViewController *presentingController;
@property(assign, nonatomic) BOOL supportRatate;

@property(class) AppDelegate *instance;

-(void) switchToMainPage;
-(void) switchToWelcomePage;

@end

