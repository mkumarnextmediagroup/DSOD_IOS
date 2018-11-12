//
//  UniteDetailViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/1.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UniteDetailViewController.h"
#import "UniteContent.h"
#import "DetailModel.h"
#import "Proto.h"

@interface UniteDetailViewController ()
{
    DetailModel *articleInfo;
}
@end

@implementation UniteDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    backTask(^() {
        self->articleInfo = [Proto queryForUniteDetailInfo:@"5be10e639a08062de04007f1"];//5bd912074192a80309fe23c1
        foreTask(^() {
            
            [self buildView];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor grayColor];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"SPONSORED CONTENT";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    
    // Do any additional setup after loading the view.
}

- (void)buildView
{
    UniteContent *content = [UniteContent new];
    [self.view addSubview:content];
    [[[[content.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT-20] install];
    [content bind:articleInfo];
    [self.view.layoutUpdate.bottom.greaterThanOrEqualTo(content) install];
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
