//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsDownloadsController.h"
#import "Common.h"
#import "DownloadsItemView.h"
#import "Proto.h"
#import "DentistFilterView.h"

@implementation CmsDownloadsController {

}

- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"DSODENTIST";
    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = 160;
    
    NSArray *ls = [Proto listBookmark];
    self.items = ls;
    
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 32);
    panel.backgroundColor=rgb255(249.0,250.0,253.0);
    
    UIButton *filterButton = [panel addButton];
    [filterButton setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    [[[[filterButton.layoutMaker topParent:4] rightParent:-10] sizeEq:24 h:24] install];
    [filterButton onClick:self action:@selector(clickFilter:)];
    return panel;
}

- (Class)viewClassOfItem:(NSObject *)item {
    return DownloadsItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    return 160;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    DownloadsItemView *itemView = (DownloadsItemView *) view;
    [itemView bind:art];
}

#pragma mark 打开刷选页面
-(void)clickFilter:(UIButton *)sender
{
    DentistFilterView *filterview=[[DentistFilterView alloc] init];
    [filterview show:^{
        //关闭block回调
    }];
}

@end
