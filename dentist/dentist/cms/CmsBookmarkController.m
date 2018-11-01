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
#import "BookmarkModel.h"

@interface CmsBookmarkController()<BookMarkItemViewDelegate>
{
    NSString *categorytext;
    NSString *typetext;
    CGFloat rowheight;
    NSMutableArray *resultArray;
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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    categorytext=nil;
    typetext=nil;
    if(self.items.count==0){
        [self refreshData];
    }
//    self.items =[Proto getBookmarksListByCategory:typetext type:categorytext];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"BOOKMARKS";
    [self.view layoutIfNeeded];
    rowheight=(self.table.frame.size.height-32)/4;
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = rowheight;
    self.isRefresh=YES;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyViewWithImageName:@"nonBookmarks" title:@"No bookmarks added yet"];
}

-(void)refreshData
{
    [self showIndicator];
    backTask(^() {
        self->resultArray  = [[Proto queryBookmarksByEmail:getLastAccount()] mutableCopy];
        foreTask(^() {
             [self hideIndicator];
            self.items=[self->resultArray copy];
        });
    });
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
    
    return rowheight;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
//    Article *art = (id) item;
//    BookMarkItemView *itemView = (BookMarkItemView *) view;
//    itemView.delegate=self;
//    [itemView bind:art];
    BookmarkModel *art = (id) item;
    BookMarkItemView *itemView = (BookMarkItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:art];
}

-(void)BookMarkActionModel:(BookmarkModel *)model
{
    //移除bookmark
    BOOL result = [Proto deleteBookmark:model._id];
    if (result) {
        [self->resultArray removeObject:model];
        self.items=[self->resultArray copy];
        [self.table reloadData];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Delete" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
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
    BookmarkModel *article = (BookmarkModel *) item;
    
    newVC.contentId = article.postId;
    newVC.toWhichPage = @"pic";
//    if ([[article.contentTypeName uppercaseString] isEqualToString:@"VIDEOS"]) {
//        newVC.toWhichPage = @"mo";
//    }else
//    {
//        newVC.toWhichPage = @"pic";
//    }
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
//        self.items =[Proto getBookmarksListByCategory:typetext type:categorytext];
    }];
}

@end
