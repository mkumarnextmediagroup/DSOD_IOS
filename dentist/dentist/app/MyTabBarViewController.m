//
//  MyTabBarViewController.m
//  dentist
//
//  Created by 孙兴国 on 2018/12/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "CareerMoreViewController.h"
#import "CustomTabbar.h"
#import "CareerExplorePage.h"
#import "CareerFindJobViewController.h"
#import "CareerMyJobViewController.h"
#import "CareerAlertsViewController.h"
#import "UIUtil.h"
#import "UIViewController+myextend.h"
#import "AppDelegate.h"
#import "MoreView.h"

@interface MyTabBarViewController ()<CustomTabBarDelegate>
{
    CustomTabBar *myTabbar;
}
@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置所有子控制器
    [self addChildViewControllers];
    
    // 2.创建自定义的tabbar
    [self createCustomTabbar];
    // Do any additional setup after loading the view.
}

- (UIBarButtonItem *)menuButton {
    return [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenu:)];
}

#pragma mark 设置所有的子控制器
- (void)addChildViewControllers {
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
    
    // 设置子控制器
    self.viewControllers = @[ncExplore, ncFindJob, ncMyJob, ncAlert];
}

#pragma mark 隐藏系统自带的tabBar，创建自定义的tabBar
- (void)createCustomTabbar {
    // 1.隐藏系统tabbar
//    self.tabBar.hidden = YES;
    
    // 2.创建自定义的tabbar
    CGRect rect;
    if (IPHONE_X) {
        rect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50 - 34, [UIScreen mainScreen].bounds.size.width, 65);
    }else
    {
        rect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 65);
    }
    
    myTabbar = [[CustomTabBar alloc] initWithFrame:rect itemCount:self.viewControllers.count];
    myTabbar.delegate = self;
    [self.view addSubview:myTabbar];
}

#pragma mark CustomTabBarDelegate方法，tabBarItem被点击
- (void)myTabbar:(CustomTabBar *)tabbar btnClicked:(NSInteger)index
{
    if (4 == index) {
        
        [[MoreView initSliderView] showFuntionBtn];
        
        
    }else{
        //设置选择的子控制器与点击的按钮相对应
        self.selectedIndex = index;
    }
}

-(void)tabbarSelected:(NSInteger)index
{
    if (myTabbar) {
        [myTabbar setTabbarSelected:index];
    }
}

@end
