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
#import "Article.h"
#import <Social/Social.h>

@interface CmsDownloadsController()<MyActionSheetDelegate>
{
    NSInteger selectIndex;
    NSMutableArray *ls;
}
@end
@implementation CmsDownloadsController {
    
}
- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ls = [NSMutableArray arrayWithArray:[Proto listBookmark]];
    self.items = nil;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
}

-(void)reloadData
{
    ls = [NSMutableArray arrayWithArray:[Proto listBookmark]];
    self.items = ls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"DOWNLOADS";
    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];
    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = 160;
    [self addEmptyViewWithImageName:@"nonDownload" title:@"No downloaded content"];
    
    
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
    NSInteger tag=[self.items indexOfObject:item];
    DownloadsItemView *itemView = (DownloadsItemView *) view;
    itemView.markButton.tag=tag;
    [itemView.markButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [itemView bind:art];
}

- (void)moreBtnClick:(UIButton *)btn
{
    selectIndex=btn.tag;
    NSArray *imgArr = [NSArray arrayWithObjects:@"deleteDown",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Delete",@"Share", nil];
    [denSheet show];
}

- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    NSLog(@"%@===%d",subLabel.text,index);
    if(index==1){
        if(self.items.count>selectIndex){
            Article *art=(Article *)self.items[selectIndex];
            UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[art.title,[NSURL URLWithString:art.resImage]] applicationActivities:nil];
            [self presentViewController:avc animated:YES completion:nil];
        }
        
        
    }else if(index==0){
        [ls removeObjectAtIndex:selectIndex];
        self.items=ls;
    }
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
