//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsBookmarkController.h"
#import "Common.h"
#import "BookMarkItemView.h"
#import "Proto.h"
#import "DentistFilterView.h"
#import "CMSDetailViewController.h"

@interface CmsBookmarkController()<BookMarkItemViewDelegate>
{
    NSString *categorytext;
    NSString *typetext;
}
@end

@implementation CmsBookmarkController

- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    categorytext=nil;
    typetext=nil;
    self.items =[Proto getBookmarksListByCategory:typetext type:categorytext];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
}

-(void)reloadData
{
    self.items = [Proto listBookmark];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"BOOKMARKS";
    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];
    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = 150;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyViewWithImageName:@"nonBookmarks" title:@"No bookmarks added yet"];
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
    itemView.delegate=self;
    [itemView bind:art];
}

-(void)BookMarkAction:(NSInteger)articleid
{
    NSLog(@"BookMarkAction=%@",@(articleid));
    //移除bookmark
    [Proto deleteBookmarks:articleid];
    self.items =[Proto getBookmarksListByCategory:typetext type:categorytext];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Delete" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)onClickItem:(NSObject *)item {
    
    //    CMSDetailViewController *detail = [CMSDetailViewController new];
    //    detail.articleInfo = (Article *) item;
    //    [self.navigationController.tabBarController presentViewController:detail animated:YES completion:nil];
    
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

#pragma mark 打开刷选页面
-(void)clickFilter:(UIButton *)sender
{
    DentistFilterView *filterview=[[DentistFilterView alloc] init];
    [filterview show:^(NSString *category, NSString *type) {
        
    } select:^(NSString *category, NSString *type) {
        categorytext=category;
        typetext=type;
        self.items =[Proto getBookmarksListByCategory:typetext type:categorytext];
    }];
}

@end
