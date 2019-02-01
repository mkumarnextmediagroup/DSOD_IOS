//
//  EducationCoursesViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/29.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationCoursesViewController.h"
#import "Common.h"
@interface EducationCoursesViewController ()

@end

@implementation EducationCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"MY COURSES";
    
    UILabel *lb = self.view.addLabel;
    lb.text = @"MY COURSES Page";
    [lb textColorMain];
    [[[lb.layoutMaker centerParent] sizeFit] install];
    // Do any additional setup after loading the view.
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
