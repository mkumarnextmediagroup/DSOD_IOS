//
//  CmsArticleCategoryPage.m
//  dentist
//
//  Created by feng zhenrong on 2018/10/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CmsArticleCategoryPage.h"
#import "Common.h"
#import "ArticleItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "StateCity.h"
#import "IdName.h"
#import "AppDelegate.h"
#import "LinearPage.h"
#import "NSDate+myextend.h"
#import "TestPage.h"
#import "YBImageBrowser.h"
#import "UIImageView+WebCache.h"
#import "DentistImageBrowserToolBar.h"
#import "BannerScrollView.h"
#import <Social/Social.h>
#import "DenActionSheet.h"
#import "DentistTabView.h"
#import "CMSModel.h"
#import "IdName.h"
#import "ArticleGSkItemView.h"
#import "DentistPickerView.h"
#import "DetinstDownloadManager.h"
#import "DsoToast.h"

@interface CmsArticleCategoryPage ()<ArticleItemViewDelegate,MyActionSheetDelegate,DentistTabViewDelegate>
{
    NSMutableArray<NSString *> *segItems;
    NSMutableArray<IdName *> *segItemsModel;
    UISegmentedControl *segView;
    UIView *panel;
    BannerScrollView *iv;
    BOOL isdeletead;
    NSInteger selectActicleId;
    NSArray *dataArray;
    NSString *contenttype;
    DentistTabView *tabView;
    UILabel *titlecontent;
     BOOL isdownrefresh;
    CMSModel *selectModel;
}
@property (nonatomic,strong) UIActivityIndicatorView *categoryiv;
@end

@implementation CmsArticleCategoryPage

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 500;
    self.isRefresh=YES;
    // Do any additional setup after loading the view.
}

- (void)createNav
{
    [self.view layoutIfNeeded];
    UIView *topVi = [UIView new];
    topVi.backgroundColor = Colors.bgNavBarColor;
    [self.view addSubview:topVi];
    [[[[[topVi.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:NAVHEIGHT] install];
    
    titlecontent = [topVi addLabel];
    titlecontent.font = [Fonts semiBold:15];
    titlecontent.textColor = [UIColor whiteColor];
    titlecontent.text = _categoryName;
    titlecontent.textAlignment = NSTextAlignmentCenter;
    [[[[titlecontent.layoutMaker leftParent:(SCREENWIDTH - 200)/2] topParent:23+NAVHEIGHT_OFFSET] sizeEq:200 h:40] install];
    
    UIButton *dismissBtn = [topVi addButton];
    [dismissBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    [[[[dismissBtn.layoutMaker leftParent:0] topParent:24+NAVHEIGHT_OFFSET] sizeEq:60 h:40] install];
    
    
    
    UILabel *line = [topVi lineLabel];
    [[[[line.layoutMaker topParent:NAVHEIGHT - 1] leftParent:0] sizeEq:SCREENWIDTH h:1] install];
    UIView *rightView = [self.view addView];
//    rightView.backgroundColor=[UIColor redColor];
    [[[[rightView.layoutMaker rightParent:0] topParent:44+NAVHEIGHT_OFFSET] sizeEq:40 h:40] install];
//    [topVi layoutIfNeeded];
//    [self.view layoutIfNeeded];
    if (self.categoryiv == nil) {
        self.categoryiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [rightView addSubview:self.categoryiv];
        self.categoryiv.tag = 990;
        self.categoryiv.hidesWhenStopped = YES;
        self.categoryiv.backgroundColor = [UIColor clearColor];
        self.categoryiv.center = rightView.center;
        
    }
    [rightView bringSubviewToFront: self.categoryiv];
    self.categoryiv.hidden=YES;
}

- (void)showCmsIndicator {
    [self.categoryiv stopAnimating];
    self.categoryiv.hidden = NO;
    [self.categoryiv startAnimating];
}

- (void)hideCmsIndicator {
    self.categoryiv.hidden = YES;
    [self.categoryiv stopAnimating];
}

- (void)onBack:(UIButton *)btn {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (Class)viewClassOfItem:(NSObject *)item {
//    CMSModel *model = (id) item;
//    if (![NSString isBlankString:model.sponsorId]) {
//        return ArticleGSkItemView.class;
//    }else{
//        return ArticleItemView.class;
//    }
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
    //    [itemView bind:art];
//    CMSModel *model = (id) item;
//    if (![NSString isBlankString:model.sponsorId]) {
//        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
//        itemView.delegate=self;
//        [itemView bindCMS:model];
//    }else{
//        ArticleItemView *itemView = (ArticleItemView *) view;
//        itemView.delegate=self;
//        [itemView bindCMS:model];
//    }
    
    
    CMSModel *model = (id) item;
    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:model];
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
    ////    [self.navigationController pushViewController:newVC animated:YES];
    //    [self pushPage:newVC];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    CMSModel *article = (CMSModel *) item;
    
    newVC.contentId = article.id;
    if ([[article.contentTypeName uppercaseString] isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    newVC.cmsmodelsArray=self.items;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

//MARK:刷新数据
-(void)refreshData
{
    [self showCmsIndicator];
    [Proto queryAllContentsByCategoryType:self.categoryId skip:0 completed:^(NSArray<CMSModel *> *array) {
        foreTask(^() {
            [self hideCmsIndicator];
            self.items=array;
        });
    }];
}


//-(void)ArticleMoreAction:(NSInteger)articleid
//{
//    selectActicleId=articleid;
//    NSLog(@"ArticleMoreAction=%@",@(articleid));
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

-(void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view
{
    CMSModel *model = (id) item;
    if(model.isBookmark){
        //删除
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from bookmarks……" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id completed:^(BOOL result) {
            foreTask(^() {
                [self.navigationController.view hideToast];
                if (result) {
                    //
                    model.isBookmark=NO;
                    ArticleItemView *itemView = (ArticleItemView *) view;
                    [itemView updateBookmarkStatus:NO];
                }
                
            });
        }];
    }else{
        //添加
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Saving to bookmarks…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto addBookmark:getLastAccount() cmsmodel:model completed:^(BOOL result) {
            foreTask(^() {
                [self.navigationController.view hideToast];
                if (result) {
                    //
                    model.isBookmark=YES;
                    ArticleItemView *itemView = (ArticleItemView *) view;
                    [itemView updateBookmarkStatus:YES];
                }
            });
        }];
    }
    
    
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            //添加
            if (selectModel) {
                UIView *dsontoastview=[DsoToast toastViewForMessage:@"Download is Add…" ishowActivity:YES];
                [self.navigationController.view showToast:dsontoastview duration:1.0 position:CSToastPositionBottom completion:nil];
                [[DetinstDownloadManager shareManager] startDownLoadCMSModel:selectModel addCompletion:^(BOOL result) {
                    
                } completed:^(BOOL result) {
                    
                }];
            }
        }
            break;
        case 1://---click the Share button
        {
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

-(void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(NSString *)categoryName
{
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    
    picker.leftTitle=localStr(@"Category");
    picker.righTtitle=localStr(@"Cancel");
    [picker show:^(NSString *result,NSString *resultname) {
        
    } rightAction:^(NSString *result,NSString *resultname) {
        
    } selectAction:^(NSString *result,NSString *resultname) {
        self.categoryId=result;
        foreTask(^{
            [self showCmsIndicator];
            self->titlecontent.text=resultname;
        });
        [Proto queryAllContentsByCategoryType:self.categoryId skip:0 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideCmsIndicator];
                self.items=array;
            });
        }];
    }];
    [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
        foreTask(^() {
            picker.arrayDic=array;
            picker.selectId=self.categoryId;
        });
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50)
    {
        if (!isdownrefresh) {
            isdownrefresh=YES;
            //在最底部
            [self showCmsIndicator];
            [Proto queryAllContentsByCategoryType:self.categoryId skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
                self->isdownrefresh=NO;
                foreTask(^() {
                    [self hideCmsIndicator];
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

@end
