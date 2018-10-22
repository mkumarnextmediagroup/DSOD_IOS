//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//  fengzhenrong 2018-09-21

#import "CmsSearchPage.h"
#import "Common.h"
#import "ArticleItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "DenActionSheet.h"
#import <Social/Social.h>

@interface CmsSearchPage()<UISearchBarDelegate,MyActionSheetDelegate,ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    BOOL issearch;
    NSString *searchKeywords;
}
/*** searchbar ***/
@property (nonatomic,strong) UISearchBar *searchBar;
/*** search result array ***/
@property (nonatomic,strong) NSArray *resultArr;
@end

@implementation CmsSearchPage {
    UITextField *searchEdit;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	UINavigationItem *item = [self navigationItem];
    item.leftBarButtonItem=nil;//hidden left menu
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.placeholder = @"Search...";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = NO;
//    for (id obj in [_searchBar subviews]) {
//        if ([obj isKindOfClass:[UIView class]]) {
//            for (id obj2 in [obj subviews]) {
//                if ([obj2 isKindOfClass:[UIButton class]]) {
//                    UIButton *btn = (UIButton *)obj2;
//                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
////                    btn.enabled =NO;
////                    [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                }
//            }
//        }
//    }
    item.titleView=_searchBar;
    if (@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    }
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 400;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyViewWithImageName:@"Icon-Search" title:@"Search by categoy name,\n author,or content type"];

    self.items = [Proto getArticleListByKeywords:searchKeywords];
    
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
    itemView.delegate=self;
    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    itemView.moreButton.tag=art.id;
    [itemView bind:art];
}

//click more button
- (void)moreBtnClick:(UIButton *)btn
{
    selectIndex=btn.tag;
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show];
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            if (![Proto checkIsDownloadByArticle:selectIndex]) {
                //添加
                [Proto addDownload:selectIndex];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Download is Add" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"点击取消");
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
            break;
        case 1://---click the Share button
        {
            NSLog(@"Share click");
            UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"Mastering the art of Dental Surgery",[NSURL URLWithString:@"http://app800.cn/i/d.png"]] applicationActivities:nil];
            [self presentViewController:avc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)onClickItem:(NSObject *)item {
    CMSDetailViewController *detail = [CMSDetailViewController new];
    detail.articleInfo = (Article *) item;
    if ([detail.articleInfo.category isEqualToString:@"VIDEOS"]) {
        detail.toWhichPage = @"mo";
    }else
    {
        detail.toWhichPage = @"pic";
    }
    [self.navigationController.tabBarController presentViewController:detail animated:YES  completion:nil];
}

-(void)ArticleMarkAction:(NSInteger)articleid
{
    NSLog(@"ArticleMarkAction=%@",@(articleid));
    if ([Proto checkIsBookmarkByArticle:articleid]) {
        //移除bookmark
        [Proto deleteBookmarks:articleid];
        self.items=[Proto getArticleListByKeywords:searchKeywords];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Delete" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        //添加bookmark
        [Proto addBookmarks:articleid];
        self.items=[Proto getArticleListByKeywords:searchKeywords];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Add" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark ---UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
   _searchBar.showsCancelButton = YES;
//    [_searchBar setShowsCancelButton:YES animated:YES];
    for (id obj in [_searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
//                    btn.enabled =YES;
//                    [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
    }
    return YES;
}
//MARK:dismiss button clicked，do this method
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.text=@"";
    [self.searchBar resignFirstResponder];
//    [_searchBar setShowsCancelButton:NO animated:YES];
     _searchBar.showsCancelButton = NO;
//    for (id obj in [_searchBar subviews]) {
//        if ([obj isKindOfClass:[UIView class]]) {
//            for (id obj2 in [obj subviews]) {
//                if ([obj2 isKindOfClass:[UIButton class]]) {
//                    UIButton *btn = (UIButton *)obj2;
//                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
//                    btn.enabled =NO;
//                    [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                }
//            }
//        }
//    }
}
//MARK:keyboard search button clicked，do this method
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    issearch=YES;
    searchKeywords=searchBar.text;
    [self.searchBar resignFirstResponder];
//    [_searchBar setShowsCancelButton:NO animated:YES];
     _searchBar.showsCancelButton = NO;
    self.items=[Proto getArticleListByKeywords:searchKeywords type:nil];
//    for (id obj in [_searchBar subviews]) {
//        if ([obj isKindOfClass:[UIView class]]) {
//            for (id obj2 in [obj subviews]) {
//                if ([obj2 isKindOfClass:[UIButton class]]) {
//                    UIButton *btn = (UIButton *)obj2;
//                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
////                    btn.enabled =NO;
////                    [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                }
//            }
//        }
//    }
}

-(void)cancelBtnClick:(UIButton *)sender
{
    NSLog(@"search cancel click");
     _searchBar.showsCancelButton = NO;
    [_searchBar setShowsCancelButton:NO animated:YES];
}

-(void)CategoryPickerSelectAction:(NSString *)result
{
    self.items=[Proto getArticleListByKeywords:searchKeywords type:result];
}

@end
