//
//  DSODetailPage.m
//  dentist
//
//  Created by Jacksun on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DSODetailPage.h"
#import "Common.h"

@interface DSODetailPage ()

@end

@implementation DSODetailPage

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"DSO COMPANY";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];

    // Do any additional setup after loading the view.
}

- (void)searchClick
{
    NSLog(@"search btn click");
}

- (void)onBack:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
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
