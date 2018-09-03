//
//  EditEduViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditEduViewController.h"

@interface EditEduViewController ()

@end

@implementation EditEduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"editEdu";
    item.leftBarButtonItem = [self navBarText:@"SAVE" action:@selector(saveBtnClick:)];
    // Do any additional setup after loading the view.
}

- (void)saveBtnClick:(UIButton *)btn
{
    NSLog(@"save");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
