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
    NSInteger pagenumber;
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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    pagenumber = 1;
    
	UINavigationItem *item = [self navigationItem];
    item.leftBarButtonItem=nil;//hidden left menu
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.placeholder = @"Search...";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = NO;
    item.titleView=_searchBar;
    if (@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    }
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 400;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyViewWithImageName:@"Icon-Search" title:@"Search by category name,\n author,or content type"];

//    self.items = [Proto getArticleListByKeywords:searchKeywords];
    
}

- (Class)viewClassOfItem:(NSObject *)item {
    return ArticleItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    //    return 430;
    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    
    CMSModel *model = (id) item;
    ArticleItemView *itemView = (ArticleItemView *) view;
    itemView.delegate=self;
    itemView.moreButton.tag=1;//;
    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [itemView bindCMS:model];
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
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    CMSModel *article = (CMSModel *) item;
    newVC.contentId = article.id;
    if ([article.categoryName isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

- (void)ArticleMarkActionModel:(CMSModel*)model
{
    if(model.isBookmark){
        //删除
        backTask(^() {
            BOOL result=[Proto deleteBookmark:model.id];
            foreTask(^() {
                if (result) {
                    //
                }
            });
        });
    }else{
        //添加
        backTask(^() {
            BOOL result=[Proto addBookmark:getLastAccount() postId:model.id title:model.title url:model.id];
            foreTask(^() {
                if (result) {
                    //
                }
            });
        });
    }
//    NSLog(@"ArticleMarkAction=%@",@(articleid));
//    if ([Proto checkIsBookmarkByArticle:articleid]) {
//        //移除bookmark
//        [Proto deleteBookmarks:articleid];
//        self.items=[Proto getArticleListByKeywords:searchKeywords];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Delete" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            NSLog(@"点击取消");
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }else{
//        //添加bookmark
//        [Proto addBookmarks:articleid];
//        self.items=[Proto getArticleListByKeywords:searchKeywords];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Add" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            NSLog(@"点击取消");
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
}

#pragma mark ---UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
   _searchBar.showsCancelButton = YES;
    for (id obj in [_searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
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
     _searchBar.showsCancelButton = NO;
}
//MARK:keyboard search button clicked，do this method
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    issearch=YES;
    searchKeywords=searchBar.text;
    [self.searchBar resignFirstResponder];
     _searchBar.showsCancelButton = NO;
//    self.items=[Proto getArticleListByKeywords:searchKeywords type:nil];
    self.items=[Proto querySearchResults:searchKeywords pageNumber:pagenumber];
//    NSLog(@"%@",self.items);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height+50)
    {
        //在最底部
        [self showIndicator];
        backTask(^() {
            NSInteger newpage=self->pagenumber+1;
            NSMutableArray *newarray=[NSMutableArray arrayWithArray:self.items];
            NSArray<CMSModel *> *array = [Proto querySearchResults:self->searchKeywords pageNumber:newpage];
            if(array && array.count>0){
                [newarray addObjectsFromArray:array];
                self->pagenumber=newpage;
            }
            foreTask(^() {
                [self hideIndicator];
                self.items=[newarray copy];
            });
        });
    }
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
