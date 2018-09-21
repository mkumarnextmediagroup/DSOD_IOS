//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsBookmarkController.h"
#import "Common.h"
#import "BookMarkItemView.h"
#import "Proto.h"
#import "DentistFilterView.h"

@implementation CmsBookmarkController

- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"BOOKMARKS";
    item.rightBarButtonItem = [self navBarText:@"" target:nil action:nil];
    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = 150;
    
    NSArray *ls = [Proto listBookmark];
    self.items = ls;
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 32);
    panel.backgroundColor=rgb255(250,251,253);
    
    UIButton *filterButton = [panel addButton];
    [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
    [[[[filterButton.layoutMaker topParent:4] rightParent:-15] sizeEq:24 h:24] install];
    [filterButton onClick:self action:@selector(clickFilter:)];
    return panel;
}

- (Class)viewClassOfItem:(NSObject *)item {
    return BookMarkItemView.class;
}
- (CGFloat)heightOfItem:(NSObject *)item {
    return 150;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    BookMarkItemView *itemView = (BookMarkItemView *) view;
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
