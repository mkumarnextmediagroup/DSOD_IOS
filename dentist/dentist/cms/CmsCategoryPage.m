//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsCategoryPage.h"
#import "Common.h"
#import "ArticleItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "DenActionSheet.h"
#import <Social/Social.h>
#import "CMSModel.h"

@interface CmsCategoryPage()<ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    NSString *type;
    NSArray *dataArray;
}
@end
@implementation CmsCategoryPage {

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = [self navigationItem];
	item.title = @"CATEGORY";
    
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 400;
    self.isRefresh=YES;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyFilterViewWithImageName:@"nonBookmarks" title:@"Search by category" filterAction:^(NSString *result,NSString *resultname) {
        type=result;
        backTask(^() {
            NSArray<CMSModel *> *array  = [Proto queryAllContentsByCategoryType:type pageNumber:1];
            foreTask(^() {
                self.items=array;
            });
        });
        
    }];
    
    self.items = nil;
}

- (Class)viewClassOfItem:(NSObject *)item {
    return ArticleItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    //    return 430;
    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
//    Article *art = (id) item;
//    ArticleItemView *itemView = (ArticleItemView *) view;
//    itemView.delegate=self;
//    itemView.moreButton.tag=art.id;
//    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [itemView bind:art];
    CMSModel *model = (id) item;
    ArticleItemView *itemView = (ArticleItemView *) view;
    itemView.delegate=self;
    itemView.moreButton.tag=1;//;
    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [itemView bindCMS:model];
}

-(void)refreshData
{
    if (type) {
        backTask(^() {
            NSArray *array  = [Proto queryAllContentsByCategoryType:type pageNumber:1];
            foreTask(^() {
                self.items=array;
            });
        });
    }
    
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
    Article *article = (Article *) item;
    newVC.contentId = [NSString stringWithFormat:@"%ld",(long)article.id];
    if ([article.categoryName isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    [viewController presentViewController:navVC animated:YES completion:NULL];
}


-(void)CategoryPickerSelectAction:(NSString *)result
{
    type=result;
    if (type) {
        backTask(^() {
            NSArray *array  = [Proto queryAllContentsByCategoryType:type pageNumber:1];
            foreTask(^() {
                self.items=array;
            });
        });
    }
//    self.items=[Proto getArticleListByType:type];
}

-(void)ArticleMarkActionModel:(CMSModel *)model
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
            BOOL result=[Proto addBookmark:getLastAccount() postId:model.id title:model.title url:model.featuredMediaId];
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
//        self.items=[Proto getArticleListByType:type];
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
//        self.items=[Proto getArticleListByType:type];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Add" preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//            NSLog(@"点击取消");
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
}

@end
