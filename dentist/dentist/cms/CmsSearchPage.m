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
#import "UIViewController+myextend.h"
#import "DsoToast.h"

@interface CmsSearchPage()<UISearchBarDelegate,MyActionSheetDelegate,ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    BOOL issearch;
    NSString *searchKeywords;
    BOOL isdownrefresh;
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
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    if(self.items.count>0){
      [self showCenterIndicator];
    }
    [Proto querySearchResults:searchKeywords skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^{
            [self hideCenterIndicator];
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
    _selectModel=model;
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
            if (_selectModel) {
                UIView *dsontoastview=[DsoToast toastViewForMessage:@"Download is Add…" ishowActivity:YES];
                [self.navigationController.view showToast:dsontoastview duration:1.0 position:CSToastPositionBottom completion:nil];
                [[DetinstDownloadManager shareManager] startDownLoadCMSModel:_selectModel addCompletion:^(BOOL result) {
                } completed:^(BOOL result) {
                }];
            }
        }
            break;
        case 1://---click the Share button
        {
            NSLog(@"Share click");
            if (_selectModel) {
                NSString *urlstr=@"";
                NSString *title=[NSString stringWithFormat:@"%@",_selectModel.title];
                NSString* type = _selectModel.featuredMedia[@"type"];
                if([type isEqualToString:@"1"] ){
                    //pic
                    NSDictionary *codeDic = _selectModel.featuredMedia[@"code"];
                    urlstr = codeDic[@"thumbnailUrl"];
                }else{
                    urlstr = _selectModel.featuredMedia[@"code"];
                }
                NSString *someid=_selectModel.id;
                if (![NSString isBlankString:urlstr]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstr]];
                        UIImage *image = [UIImage imageWithData:data];
                        if (image) {
                            NSURL *shareurl = [NSURL URLWithString:getShareUrl(@"content", someid)];
                            NSArray *activityItems = @[shareurl,title,image];
                            
                            UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                            [self presentViewController:avc animated:YES completion:nil];
                        }
                    });
                }else{
                    NSURL *shareurl = [NSURL URLWithString:getShareUrl(@"content", someid)];
                    NSArray *activityItems = @[shareurl,title];
                    
                    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                    [self presentViewController:avc animated:YES completion:nil];
                }
                
            }else{
                NSString *msg=@"";
                msg=@"error";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"点击取消");
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
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
    newVC.cmsmodelsArray=self.items;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

- (void) handleDeleteBookmark:(HttpResult *)result view:(UIView *)view model:(CMSModel *)model {
    [self.navigationController.view hideToast];
    if (result.OK) {
        model.isBookmark=NO;
        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
        [itemView updateBookmarkStatus:NO];
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

-(void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view
{
    CMSModel *model = (id) item;
    if(model.isBookmark){
        //删除
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from bookmarks……" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id completed:^(HttpResult *result) {
            foreTask(^() {
                [self handleDeleteBookmark:result view:view model:model];
            });
        }];
    }else{
        //添加
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Saving to bookmarks…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto addBookmark:getLastAccount() cmsmodel:model completed:^(HttpResult *result) {
            foreTask(^() {
                [self handleAddBookmark:result view:view model:model];
            });
        }];
    }
}

- (void) handleAddBookmark:(HttpResult *)result view:(UIView *)view model:(CMSModel *)model {
    [self.navigationController.view hideToast];
    if (result.OK) {
        //
        model.isBookmark=YES;
        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
        [itemView updateBookmarkStatus:YES];
    }else{
        if(result.code==2033){
            model.isBookmark=YES;
            ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
            [itemView updateBookmarkStatus:YES];
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
//    self.items=[Proto querySearchResults:searchKeywords pageNumber:pagenumber];
    [self showCenterIndicator];
    [Proto querySearchResults:searchKeywords skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^{
            [self hideCenterIndicator];
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
        if (!isdownrefresh) {
            isdownrefresh=YES;
            [self showCenterIndicator];
            [Proto querySearchResults:searchKeywords skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
                foreTask(^{
                    self->isdownrefresh=NO;
                    [self hideCenterIndicator];
                    if(array && array.count>0){
                        NSMutableArray *newarray=[NSMutableArray arrayWithArray:self.items];
                        [newarray addObjectsFromArray:array];
                        self.items=[newarray copy];
                    }
                    
                });
            }];
        }
        
        
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
