//
//  GSKViewController.m
//  dentist
//
//  Created by Jacksun on 2018/10/12.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "GSKViewController.h"
#import "Common.h"
#import "ArticleItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "StateCity.h"
#import "UIView+customed.h"
#import "IdName.h"
#import "AppDelegate.h"
#import "LinearPage.h"
#import "NSDate+myextend.h"
#import "TestPage.h"
#import "GSKItemView.h"
#import "DenActionSheet.h"
#import <Social/Social.h>
#import "DentistTabView.h"
#import "CMSModel.h"
#import "IdName.h"

@interface GSKViewController ()<UIScrollViewDelegate,GSKItemViewViewDelegate,MyActionSheetDelegate,DentistTabViewDelegate>
{
    NSMutableArray<NSString *> *segItems;
    UISegmentedControl *segView;
    UILabel *typeLabel;
    UILabel *dateLabel;
    
    NSInteger selectActicleId;
    NSString *category;
    NSString *type;
    DentistTabView *tabView;
    NSMutableArray<IdName *> *segItemsModel;
    NSInteger pagenumber;
    NSString *contentTypeId;
}
@end

#define edge 16;

@implementation GSKViewController

- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    segItems = [NSMutableArray arrayWithArray:@[@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"]];
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

    UINavigationItem *item = self.navigationItem;
    item.title = @"SPONSORED CONTENT";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];

    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 150;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isRefresh=YES;
//    category=@"LATEST";
//    self.items = [Proto getArticleListByAuthor:_author category:category type:type];
    
}

//MARK:刷新数据
-(void)refreshData
{
    pagenumber=1;
    category=@"LATEST";
    contentTypeId=nil;
    self.table.tableHeaderView = [self makeHeaderView];
    [self showIndicator];
    backTask(^() {
        segItemsModel  = [Proto queryContentTypes];
        IdName *latestmodel=[IdName new];
        latestmodel.id=@"0";
        latestmodel.name=@"LATEST";
        [segItemsModel insertObject:latestmodel atIndex:0];
        NSArray<CMSModel *> *array  = [Proto queryAllContentsBySponsorAndContentType:_sponsorId contentTypeId:contentTypeId pageNumber:pagenumber];
        foreTask(^() {
            [self hideIndicator];
            tabView.modelArr=segItemsModel;
            self.items=array;
        });
    });
    //    self.items=[Proto getArticleListByCategory:category type:contenttype];
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)makeHeaderView2 {
//    UIView *seg = [self makeSegPanel];
//    seg.frame = makeRect(0, 0, SCREENWIDTH, 51);
//    return seg;
    UIView *headerview = [UIView new];
    headerview.frame = makeRect(0, 0, SCREENWIDTH, 51);
    [headerview addSubview:tabView];
    tabView=[DentistTabView new];
    tabView.delegate=self;
    [headerview addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:51] install];
//    tabView.titleArr=segItems;
    tabView.modelArr=segItemsModel;
    return headerview;
}

- (UIView *)makeHeaderView {
    
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 300);
    UIImageView *iv = [panel addImageView];
    [iv scaleFillAspect];
    iv.imageName = @"GSKPic";
    [[[[[[iv layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:249] install];
    
    UIButton *closeAd = [panel addButton];
    [closeAd setImage:[UIImage imageNamed:@"close-white"] forState:UIControlStateNormal];
    [[[[closeAd.layoutMaker topParent:22] rightParent:-22] sizeEq:24 h:24] install];
    [closeAd onClick:self action:@selector(clickCloseAd:)];
    
//    UIView *seg = [self makeSegPanel];
//    [panel addSubview:seg];
//    [[[[[seg.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];
    tabView=[DentistTabView new];
    tabView.delegate=self;
    [panel addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];
//    tabView.titleArr=segItems;
    tabView.modelArr=segItemsModel;
    
    return panel;
}

- (UIView *)makeSegPanel {
    CGFloat segw;
    segw=SCREENWIDTH*2/7.0;
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:segItems];
    UIImage *img = colorImage(makeSize(1, 1), rgba255(221, 221, 221, 100));
    [seg setDividerImage:img forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [seg setTitleTextAttributes:@{NSFontAttributeName: [Fonts semiBold:12], NSForegroundColorAttributeName: Colors.textMain} forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{NSFontAttributeName: [Fonts semiBold:12], NSForegroundColorAttributeName: Colors.textMain} forState:UIControlStateSelected];
    
    //colorImage(makeSize(1, 1), rgba255(247, 247, 247, 255))
    [seg setBackgroundImage:[UIImage imageNamed:@"seg-bg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [seg setBackgroundImage:[UIImage imageNamed:@"seg-sel"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    for (NSUInteger i = 0; i < segItems.count; ++i) {
        [seg setWidth:segw forSegmentAtIndex:i];
    }
    seg.selectedSegmentIndex = 0;
    
    UIScrollView *sv = [UIScrollView new];
    [sv addSubview:seg];
    
    sv.contentSize = makeSize(segw * segItems.count, 50);
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    segView = seg;
    [seg addTarget:self action:@selector(onSegValueChanged:) forControlEvents:UIControlEventValueChanged];
    return sv;
}

- (void)onSegValueChanged:(id)sender {
    NSInteger n = segView.selectedSegmentIndex;
    NSString *title = segItems[n];
    Log(@(n ), title);
    category=title;
//    self.items = [Proto getArticleListByAuthor:_author category:category type:type];
    UIScrollView *segscrollView=(UIScrollView *)segView.superview;
    [segscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //
    CGFloat segw;
    segw=SCREENWIDTH*2/7.0;

    CGFloat leftsegpoint=n*segw;
    //right
    CGFloat rightsegpoint=segscrollView.contentSize.width-leftsegpoint;
    CGFloat rightspace=(rightsegpoint-segscrollView.frame.size.width);
    if (rightspace<=0) {
        CGFloat rightbottomoffset=segscrollView.contentSize.width-segscrollView.bounds.size.width;
        [segscrollView setContentOffset:CGPointMake(rightbottomoffset, 0) animated:YES];
    }else{
        //left
        [segscrollView setContentOffset:CGPointMake(leftsegpoint, 0) animated:YES];
    }
}

- (void)clickCloseAd:(id)sender {
    self.table.tableHeaderView = [self makeHeaderView2];
}

- (Class)viewClassOfItem:(NSObject *)item {
    return GSKItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    return 150;
//    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
//    Article *art = (id) item;
//    GSKItemView *itemView = (GSKItemView *) view;
//    itemView.delegate=self;
//    [itemView bind:art];
    
    CMSModel *model = (id) item;
    GSKItemView *itemView = (GSKItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:model];
}

- (void)onClickItem:(NSObject *)item {

    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    Article *article = (Article *) item;
    if ([article.categoryName isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    [self.navigationController pushViewController:newVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50)
    {
        //在最底部
        [self showIndicator];
        backTask(^() {
            NSInteger newpage=pagenumber+1;
            NSMutableArray *newarray=[NSMutableArray arrayWithArray:self.items];
            NSArray<CMSModel *> *array  = [Proto queryAllContentsBySponsorAndContentType:_sponsorId contentTypeId:contentTypeId pageNumber:newpage];
            if(array && array.count>0){
                [newarray addObjectsFromArray:array];
                pagenumber=newpage;
            }
            foreTask(^() {
                [self hideIndicator];
                self.items=[newarray copy];
            });
        });
    }
}



-(void)articleMoreAction:(NSInteger)articleid
{
    selectActicleId=articleid;
    NSLog(@"ArticleMoreAction=%@",@(articleid));
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show:self.view];
}

-(void)articleMarkActionView:(NSObject *)item view:(UIView *)view
{
    CMSModel *model = (id) item;
    if(model.isBookmark){
        //删除
        backTask(^() {
            BOOL result=[Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id];
            foreTask(^() {
                NSString *msg=@"";
                if (result) {
                    //
                    model.isBookmark=NO;
                    GSKItemView *itemView = (GSKItemView *) view;
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
        });
    }else{
        //添加
        backTask(^() {
            BOOL result=[Proto addBookmark:getLastAccount() postId:model.id title:model.title url:model.featuredMediaId];
            foreTask(^() {
                NSString *msg=@"";
                if (result) {
                    //
                    model.isBookmark=YES;
                    GSKItemView *itemView = (GSKItemView *) view;
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
        });
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

-(void)GSKCategoryPickerSelectAction:(NSString *)result
{
//    type=result;
//    self.items = [Proto getArticleListByAuthor:_author category:category type:type];
}
#pragma mark -------DentistTabViewDelegate
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    pagenumber=1;
    if (segItemsModel.count>index) {
        IdName *model=segItemsModel[index];
        Log(model.id, model.name);
        [self showIndicator];
        backTask(^() {
            if ([model.id isEqualToString:@"0"]) {
                contentTypeId=nil;
            }else{
                contentTypeId=model.id;
            }
            NSArray<CMSModel *> *array  = [Proto queryAllContentsBySponsorAndContentType:_sponsorId contentTypeId:contentTypeId pageNumber:pagenumber];
            foreTask(^() {
                [self hideIndicator];
                self.items=array;
            });
        });
    }
}

@end

