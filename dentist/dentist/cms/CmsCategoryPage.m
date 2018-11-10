//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsCategoryPage.h"
#import "Common.h"
#import "ArticleGSkItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "DenActionSheet.h"
#import <Social/Social.h>
#import "CMSModel.h"
#import "DentistPickerView.h"
#import "DetinstDownloadManager.h"

@interface CmsCategoryPage()<ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    NSString *type;
    NSArray *dataArray;
    NSInteger pagenumber;
    BOOL isdownrefresh;
    CMSModel *selectModel;
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
        self->type=result;
        [self showIndicator];
        [Proto queryAllContentsByCategoryType:self->type pageNumber:self->pagenumber completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                self.items=array;
            });
        }];
        
    }];
    self.items = nil;
}

- (Class)viewClassOfItem:(NSObject *)item {
    return ArticleGSkItemView.class;
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

-(void)refreshData
{
    if (type) {
        pagenumber=1;
        [self showIndicator];
        [Proto queryAllContentsByCategoryType:self->type pageNumber:self->pagenumber completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                self.items=array;
            });
        }];
    }
    
}

//click more button
//- (void)moreBtnClick:(UIButton *)btn
//{
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
            if (selectModel) {
                NSString *urlstr=@"";
                NSString *title=[NSString stringWithFormat:@"%@",selectModel.title];
                NSString* type = selectModel.featuredMedia[@"type"];
                if([type isEqualToString:@"1"] ){
                    //pic
                    NSDictionary *codeDic = selectModel.featuredMedia[@"code"];
                    urlstr = codeDic[@"thumbnailUrl"];
                }else{
                    urlstr = selectModel.featuredMedia[@"code"];
                }
                NSString *someid=selectModel.id;
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


-(void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName
{
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    
    picker.leftTitle=localStr(@"Category");
    picker.righTtitle=localStr(@"Cancel");
    [picker show:^(NSString *result,NSString *resultname) {
        
    } rightAction:^(NSString *result,NSString *resultname) {
        
    } selectAction:^(NSString *result,NSString *resultname) {
        self->pagenumber=1;
        [self showIndicator];
        [Proto queryAllContentsByCategoryType:result pageNumber:self->pagenumber completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                self.items=array;
            });
        }];
    }];
    [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
        foreTask(^() {
            picker.arrayDic=array;
        });
    }];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50)
    {
        if (pagenumber>=1 && !isdownrefresh) {
            isdownrefresh=YES;
            //在最底部
            [self showIndicator];
            [Proto queryAllContentsByCategoryType:self->type pageNumber:self->pagenumber+1 completed:^(NSArray<CMSModel *> *array) {
                self->isdownrefresh=NO;
                foreTask(^() {
                    [self hideIndicator];
                    if(array && array.count>0){
                        NSMutableArray *newarray=[NSMutableArray arrayWithArray:self.items];
                        [newarray addObjectsFromArray:array];
                        self->pagenumber++;
                        self.items=[newarray copy];
                    }
                });
            }];
        }
        
    }
}

@end
