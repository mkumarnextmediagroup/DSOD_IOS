//
//  EducationSearchViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/13.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationSearchViewController.h"
#import "Common.h"

@interface EducationSearchViewController ()

@end

@implementation EducationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"Search";
    if (self.tabBarController != nil) {
    }else{
        item.leftBarButtonItem = [self navBarBack:self action:@selector(back)];
    }
    
    
    UILabel *lb = self.view.addLabel;
    lb.text = @"Search Page";
    [lb textColorMain];
    [[[lb.layoutMaker centerParent] sizeFit] install];
    // Do any additional setup after loading the view.
}

/**
 close page
 */
-(void)back{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
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
