//
//  EducationBookmarksViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/29.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationBookmarksViewController.h"
#import "Common.h"
@interface EducationBookmarksViewController ()

@end

@implementation EducationBookmarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"BOOKMARKS";
    
    UILabel *lb = self.view.addLabel;
    lb.text = @"BOOKMARKS Page";
    [lb textColorMain];
    [[[lb.layoutMaker centerParent] sizeFit] install];
    // Do any additional setup after loading the view.
}

@end
