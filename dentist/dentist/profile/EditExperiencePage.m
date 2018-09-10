//
//  EditExperiencePage.m
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditExperiencePage.h"
#import "Common.h"

@interface EditExperiencePage ()

@end

@implementation EditExperiencePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UINavigationItem *item = self.navigationItem;
    item.title = localStr(@"editExperience");
    item.rightBarButtonItem = [self navBarText:@"SAVE" target: self  action:@selector(saveBtnClick:)];
    item.leftBarButtonItem = [self navBarImage:@"back_arrow"  target: self action:@selector(back)];
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick:(UIButton *)btn
{
    NSLog(@"save");
}

- (void)delBtnClick:(UIButton *)btn
{
    NSLog(@"del");
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
