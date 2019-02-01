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
#import "DsoToast.h"
#import "CMSModel.h"

@interface CmsBookmarkController()<BookMarkItemViewDelegate>
{
    NSMutableArray *resultArray;
    UIView *nullFilterView;
    BOOL isdownrefresh;
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
    _rowheight=(self.table.frame.size.height-32)/4;
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = _rowheight;
    self.isRefresh=YES;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyViewWithImageName:@"nonBookmarks" title:@"No bookmarks added yet"];
}
#pragma mark ----Public method

/**
 查询bookmark列表数据
 query bookmark list data
 */
-(void)refreshData
{
    [self showIndicator];
    [Proto queryBookmarksByEmail:getLastAccount() categoryId:self->_categoryId contentTypeId:self->_contentTypeId skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^() {
            self->resultArray=[NSMutableArray arrayWithArray:array];
            [self hideIndicator];
            self.items=[self->resultArray copy];
            [self updateFilterView];
        });
    }];
}

/**
set the filter view
 */
-(void)updateFilterView
{
    if (!nullFilterView) {
        CGFloat _topBarH = 0;
        if (self.navigationController != nil) {
            _topBarH = NAVHEIGHT;
        }
        nullFilterView=[self makeHeaderView];
        nullFilterView.frame=makeRect(0, _topBarH, SCREENWIDTH, 32);
        [self.view addSubview:nullFilterView];
        nullFilterView.hidden=YES;
    }
    if (self.items.count==0 && (self->_categoryId || self->_contentTypeId) ) {
        nullFilterView.hidden=NO;
    }else{
        nullFilterView.hidden=YES;
    }
}

/**
 表头视图
 table Header View
 */
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

#pragma mark ----table method

/**
 table cell class
 */
- (Class)viewClassOfItem:(NSObject *)item {
    return BookMarkItemView.class;
}
/**
 table cell height
 */
- (CGFloat)heightOfItem:(NSObject *)item {
    
    return _rowheight;
}

/**
 table cell view
 */
- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    BookmarkModel *art = (id) item;
    BookMarkItemView *itemView = (BookMarkItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:art];
}

/**
 click table cell event；click it，go to the article detail page
 */
- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    BookmarkModel *article = (BookmarkModel *) item;
    
    newVC.contentId = article.postId;
    newVC.cmsmodelsArray=self.items;
    newVC.modelIndexOfArray = (int)indexPath.row;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

#pragma mark -----BookMarkItemViewDelegate
/**
 Article bookmark delete event
 */
-(void)BookMarkActionModel:(BookmarkModel *)model
{
    //移除bookmark
    UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from bookmarks……" ishowActivity:YES];
    [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
    [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.postId completed:^(HttpResult *result) {
        foreTask(^{
            [self handleDeleteBookmarkWithResult:result and:model];
        });
    }];
}

/**
 Article bookmark delete result method
 */
- (void)handleDeleteBookmarkWithResult:(HttpResult *)result and:(BookmarkModel *)model  {
    [self.navigationController.view hideToast];
    if (result.OK) {
        [self->resultArray removeObject:model];
        self.items=[self->resultArray copy];
        [self.table reloadData];
    }else{
        NSString *message=result.msg;
        if([NSString isBlankString:message]){
            message=@"Failed";
        }
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window makeToast:message
                 duration:1.0
                 position:CSToastPositionBottom];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --------Filter view

/**
 open Filter view
 */
-(void)clickFilter:(UIButton *)sender
{
    DentistFilterView *filterview=[[DentistFilterView alloc] init];
    filterview.categorytext=self->_categoryId;
    filterview.typetext=self->_contentTypeId;
    [filterview show:^(NSString *category, NSString *type) {
    } select:^(NSString *category, NSString *type) {
        [self handleSelectFilterWithCategory:category andType:type];
    }];
}

/**
   Re-query  bookmark list data based on the categorytype and conten type returned by the callback
   @param category category type id
   @param type content type id
   **/
- (void)handleSelectFilterWithCategory:(NSString *) category andType:(NSString *)type {
    self->_categoryId =category;
    self->_contentTypeId=type;
    [self showIndicator];
    [Proto queryBookmarksByEmail:getLastAccount() categoryId:self->_categoryId contentTypeId:self->_contentTypeId skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^() {
            [self handleQueryBookmarks:array];
        });
    }];
}

/**
 the result of Re-query  bookmark list data
 */
- (void)handleQueryBookmarks:(NSArray<CMSModel *> *)array {
    self->resultArray=[NSMutableArray arrayWithArray:array];
    [self hideIndicator];
    self.items=[self->resultArray copy];
    [self updateFilterView];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50)
    {
        NSLog(@"==================================下啦刷选");
        if (!isdownrefresh) {
            isdownrefresh=YES;
            //在最底部
            [self showIndicator];
            [Proto queryBookmarksByEmail:getLastAccount() categoryId:self->_categoryId contentTypeId:self->_contentTypeId skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
                [self handleLoadmore:array];
            }];
        }
    }
}

/**
 load more bookmark data
 */
- (void)handleLoadmore:(NSArray<CMSModel *> *) array {
    self->isdownrefresh=NO;
    foreTask(^() {
        [self hideIndicator];
        if(array && array.count>0){
            [self->resultArray addObjectsFromArray:array];
            self.items=[self->resultArray copy];
            [self updateFilterView];
        }
    });
}

@end
