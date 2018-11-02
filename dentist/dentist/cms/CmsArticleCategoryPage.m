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
    NSInteger pagenumber;
    UILabel *titlecontent;
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
    CMSModel *model = (id) item;
    if (![NSString isBlankString:model.sponsorId]) {
        return ArticleGSkItemView.class;
    }else{
        return ArticleItemView.class;
    }
    
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
    CMSModel *model = (id) item;
    if (![NSString isBlankString:model.sponsorId]) {
        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
        itemView.delegate=self;
        [itemView bindCMS:model];
    }else{
        ArticleItemView *itemView = (ArticleItemView *) view;
        itemView.delegate=self;
        [itemView bindCMS:model];
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
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

//MARK:刷新数据
-(void)refreshData
{
    pagenumber=1;
    [self showCmsIndicator];
    [Proto queryAllContentsByCategoryType:self.categoryId pageNumber:self->pagenumber completed:^(NSArray<CMSModel *> *array) {
        foreTask(^() {
            [self hideCmsIndicator];
            self.items=array;
        });
    }];
}


-(void)ArticleMoreAction:(NSInteger)articleid
{
    selectActicleId=articleid;
    NSLog(@"ArticleMoreAction=%@",@(articleid));
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show];
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
                    ArticleItemView *itemView = (ArticleItemView *) view;
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
        [Proto addBookmark:getLastAccount() postId:model.id title:model.title url:model.featuredMediaId categoryId:model.categoryId contentTypeId:model.contentTypeId completed:^(BOOL result) {
            foreTask(^() {
                NSString *msg=@"";
                if (result) {
                    //
                    model.isBookmark=YES;
                    ArticleItemView *itemView = (ArticleItemView *) view;
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

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            //添加
            [Proto addDownload:selectActicleId];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Download is Add" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
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
        self->pagenumber=1;
        [Proto queryAllContentsByCategoryType:self.categoryId pageNumber:self->pagenumber completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideCmsIndicator];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50)
    {
        //在最底部
        [self showCmsIndicator];
        [Proto queryAllContentsByCategoryType:self.categoryId pageNumber:self->pagenumber+1 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideCmsIndicator];
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

@end
