//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//  fengzhenrong 2018-09-21

#import "CmsSearchPage.h"
#import "Common.h"
#import "ArticleGSkItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "DenActionSheet.h"
#import <Social/Social.h>
#import "DetinstDownloadManager.h"
#import "CmsArticleCategoryPage.h"
@interface CmsSearchPage()<UISearchBarDelegate,MyActionSheetDelegate,ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    NSInteger pagenumber;
    BOOL issearch;
    NSString *searchKeywords;
    CMSModel *selectModel;
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
    
	UINavigationItem *item = [self navigationItem];
    item.rightBarButtonItem=nil;
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
    self.isRefresh=YES;

//    self.items = [Proto getArticleListByKeywords:searchKeywords];
    
}

//MARK:刷新数据
-(void)refreshData
{
    if (self.items.count==0) {
        self.items=nil;
    }
    [Proto querySearchResults:searchKeywords skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^{
            self.items=array;
        });
    }];
}

- (Class)viewClassOfItem:(NSObject *)item {
    return ArticleGSkItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    //    return 430;
    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    
//    CMSModel *model = (id) item;
//    ArticleItemView *itemView = (ArticleItemView *) view;
//    itemView.delegate=self;
////    itemView.moreButton.tag=1;//;
////    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [itemView bindCMS:model];
    
    
    CMSModel *model = (id) item;
    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:model];
}

//click more button
//- (void)moreBtnClick:(UIButton *)btn
//{
//    selectIndex=btn.tag;
//    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
//    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
//    [denSheet show];
//}


-(void)ArticleMoreActionModel:(CMSModel *)model
{
    selectModel=model;
    NSLog(@"ArticleMoreAction=%@",model.id);
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show];
    [[DentistDataBaseManager shareManager] CheckIsDowned:model completed:^(NSInteger isdown) {
        foreTask(^{
            if (isdown) {
                [denSheet updateActionTitle:@[@"Update",@"Share"]];
            }
        });
    }];
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            if (selectModel) {
                [[DetinstDownloadManager shareManager] startDownLoadCMSModel:selectModel addCompletion:^(BOOL result) {
                    
                    foreTask(^{
                        NSString *msg=@"";
                        if (result) {
                            msg=@"Download is Add";
                        }else{
                            msg=@"error";
                        }
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                            NSLog(@"点击取消");
                        }]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    });
                } completed:^(BOOL result) {
                    
                }];
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

-(void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view
{
    CMSModel *model = (id) item;
    if(model.isBookmark){
        //删除
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id completed:^(BOOL result) {
            foreTask(^() {
                NSString *msg=@"";
                if (result) {
                    //
                    model.isBookmark=NO;
                    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                    [itemView updateBookmarkStatus:NO];
                    msg=@"Bookmarks is Delete";
                }else{
                    msg=@"error";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"点击取消");
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }];
    }else{
        //添加
        [Proto addBookmark:getLastAccount() cmsmodel:model completed:^(BOOL result) {
            foreTask(^() {
                NSString *msg=@"";
                if (result) {
                    //
                    model.isBookmark=YES;
                    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                    [itemView updateBookmarkStatus:YES];
                    msg=@"Bookmarks is Add";
                }else{
                    msg=@"error";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"点击取消");
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }];
    }
    
    
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
    pagenumber=1;
    searchKeywords=searchBar.text;
    [self.searchBar resignFirstResponder];
     _searchBar.showsCancelButton = NO;
//    self.items=[Proto getArticleListByKeywords:searchKeywords type:nil];
//    self.items=[Proto querySearchResults:searchKeywords pageNumber:pagenumber];
    [Proto querySearchResults:searchKeywords skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^{
            self.items=array;
        });
    }];
//    NSLog(@"%@",self.items);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height+50)
    {
        [Proto querySearchResults:searchKeywords skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
            foreTask(^{
                if(array && array.count>0){
                    NSMutableArray *newarray=[NSMutableArray arrayWithArray:self.items];
                    [newarray addObjectsFromArray:array];
                    self.items=[newarray copy];
                }
                
            });
        }];
        
    }
}

-(void)cancelBtnClick:(UIButton *)sender
{
    NSLog(@"search cancel click");
     _searchBar.showsCancelButton = NO;
    [_searchBar setShowsCancelButton:NO animated:YES];
}

-(void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName
{
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CmsArticleCategoryPage *newVC = [[CmsArticleCategoryPage alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    
    newVC.categoryId=categoryId;
    newVC.categoryName=categoryName;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}


@end
