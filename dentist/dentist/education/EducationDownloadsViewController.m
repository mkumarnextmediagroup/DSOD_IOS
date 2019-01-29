//
//  EducationDownloadsViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/29.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationDownloadsViewController.h"
#import "Common.h"
@interface EducationDownloadsViewController ()

@end

@implementation EducationDownloadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"DOWNLOADS";
    
    UILabel *lb = self.view.addLabel;
    lb.text = @"DOWNLOADS Page";
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
