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

@interface CmsSearchPage()<UISearchBarDelegate,MyActionSheetDelegate>
/*** searchbar ***/
@property (nonatomic,strong) UISearchBar *searchBar;
/*** search result array ***/
@property (nonatomic,strong) NSArray *resultArr;
@end

@implementation CmsSearchPage {
    UITextField *searchEdit;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	UINavigationItem *item = [self navigationItem];
    item.leftBarButtonItem=nil;//hidden left menu
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.placeholder = @"Search";
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
    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [itemView bind:art];
}

//click more button
- (void)moreBtnClick:(UIButton *)btn
{
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
    [self.navigationController.tabBarController presentViewController:detail animated:YES  completion:nil];
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
    NSArray *ls = [Proto listArticle];
    self.items=ls;
    [self.searchBar resignFirstResponder];
//    [_searchBar setShowsCancelButton:NO animated:YES];
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
}

-(void)cancelBtnClick:(UIButton *)sender
{
    NSLog(@"search cancel click");
     _searchBar.showsCancelButton = NO;
    [_searchBar setShowsCancelButton:NO animated:YES];
}

@end
