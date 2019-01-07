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
    UINavigationItem *item = self.navigationItem;
    item.title = @"SPONSORED CONTENT";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
}

- (void)buildView {
    UniteContent *content = [UniteContent new];
    [self.view addSubview:content];
    [[[[content.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT-20] install];
    [content bind:articleInfo];
    [self.view.layoutUpdate.bottom.greaterThanOrEqualTo(content) install];
}

- (void)onBack:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
