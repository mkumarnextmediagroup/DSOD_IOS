//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//  fengzhenrong 2018-09-21

#import "CmsSearchPage.h"
#import "Common.h"
#import "ArticleItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"

@interface CmsSearchPage()<UISearchBarDelegate>
/*** 搜索bar ***/
@property (nonatomic,strong) UISearchBar *searchBar;
/*** 搜索结果数组 ***/
@property (nonatomic,strong) NSArray *resultArr;
@end

@implementation CmsSearchPage {
    UITextField *searchEdit;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	UINavigationItem *item = [self navigationItem];
    item.leftBarButtonItem=nil;//隐藏左边menu
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.placeholder = @"Search";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    item.titleView=_searchBar;
    
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 400;
    [self addEmptyViewWithImageName:@"Icon-Search" title:@"Search by categoy name,\n author,or content type"];

    self.items = nil;
    
//    searchEdit = [self.navigationController.view addEditSearch];
//    searchEdit.delegate = self;
//    [[[[searchEdit.layoutMaker leftParent:16] topParent:22] sizeEq:SCREENWIDTH - 95 h:EDIT_HEIGHT] install];
//
//    UINavigationItem *item = [self navigationItem];
//    item.rightBarButtonItem = [self navBarText:@"Cancel" target:self action:@selector(cancelBtnClick:)];
//    item.leftBarButtonItem = [self navBarText:@"" target:self action:@selector(cancelBtnClick:)];
//
//    [self buildView];
}

- (Class)viewClassOfItem:(NSObject *)item {
    return ArticleItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    //    return 430;
    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    ArticleItemView *itemView = (ArticleItemView *) view;
    [itemView bind:art];
}

- (void)onClickItem:(NSObject *)item {
    CMSDetailViewController *detail = [CMSDetailViewController new];
    detail.articleInfo = (Article *) item;
    [self.navigationController.tabBarController presentViewController:detail animated:YES  completion:nil];
}

#pragma mark ---UISearchBarDelegate
//MARK:取消按钮被按下时，执行的方法
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
//MARK:键盘中，搜索按钮被按下，执行的方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSArray *ls = [Proto listArticle];
    self.items=ls;
    [self.searchBar resignFirstResponder];
}

@end
