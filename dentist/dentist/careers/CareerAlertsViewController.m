//
//  CareerAlertsViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerAlertsViewController.h"
#import "AppDelegate.h"
#import "UIViewController+myextend.h"

@interface CareerAlertsViewController ()

@end

@implementation CareerAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"Alerts";
    self.view.backgroundColor=[UIColor whiteColor];
    
    

    // Do any additional setup after loading the view.
}

- (void)backToFirst
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabvc=(UITabBarController *)appdelegate.careersPage;
    [tabvc setSelectedIndex:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
