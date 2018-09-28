//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsDownloadsController.h"
#import "Common.h"
#import "DownloadsItemView.h"
#import "Proto.h"
#import "DentistFilterView.h"
#import "DenActionSheet.h"

@interface CmsDownloadsController()<MyActionSheetDelegate>

@end
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
    item.title = @"DOWNLOADS";
    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];
    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = 160;
    
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
    return DownloadsItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    return 160;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    DownloadsItemView *itemView = (DownloadsItemView *) view;
    [itemView.markButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [itemView bind:art];
}

- (void)moreBtnClick:(UIButton *)btn
{
    NSArray *imgArr = [NSArray arrayWithObjects:@"deleteDown",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Delete",@"Share", nil];
    [denSheet show];
}

- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    NSLog(@"%@===%d",subLabel.text,index);
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
