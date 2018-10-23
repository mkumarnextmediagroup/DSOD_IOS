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
#import "CMSDetailViewController.h"

@interface CmsDownloadsController()<MyActionSheetDelegate>
{
    NSInteger selectIndex;
    NSMutableArray *ls;
    NSString *categorytext;
    NSString *typetext;
    CGFloat rowheight;
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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    categorytext=nil;
    typetext=nil;
    self.items = [Proto getDownloadListByCategory:typetext type:categorytext];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
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
    
    [self.view layoutIfNeeded];
    rowheight=(self.table.frame.size.height-32)/4;
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = rowheight;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return rowheight;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    NSInteger tag=[self.items indexOfObject:item];
    DownloadsItemView *itemView = (DownloadsItemView *) view;
    itemView.markButton.tag=art.id;
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

- (void)onClickItem:(NSObject *)item {
    
//    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
//    newVC.articleInfo = (Article *) item;
//    if ([newVC.articleInfo.category isEqualToString:@"VIDEOS"]) {
//        newVC.toWhichPage = @"mo";
//    }else
//    {
//        newVC.toWhichPage = @"pic";
//    }
//    [self.navigationController pushViewController:newVC animated:YES];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    newVC.articleInfo = (Article *) item;
    if ([newVC.articleInfo.category isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    NSLog(@"%@===%d",subLabel.text,index);
    if(index==1){
//        if(self.items.count>selectIndex){
//            Article *art=(Article *)self.items[selectIndex];
//            UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[art.title,[NSURL URLWithString:art.resImage]] applicationActivities:nil];
//            [self presentViewController:avc animated:YES completion:nil];
//        }
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"Mastering the art of Dental Surgery",[NSURL URLWithString:@"http://app800.cn/i/d.png"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];
        
    }else if(index==0){
        [Proto deleteDownload:selectIndex];
        self.items =[Proto getDownloadListByCategory:typetext type:categorytext];
    }
}

#pragma mark 打开刷选页面
-(void)clickFilter:(UIButton *)sender
{
    DentistFilterView *filterview=[[DentistFilterView alloc] init];
    [filterview show:^(NSString *category, NSString *type) {
    }select:^(NSString *category, NSString *type) {
        categorytext=category;
        typetext=type;
        self.items =[Proto getDownloadListByCategory:typetext type:categorytext];
    }];
}

@end
