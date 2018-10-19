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

@interface GSKViewController ()<UIScrollViewDelegate,GSKItemViewViewDelegate,MyActionSheetDelegate>
{
    NSMutableArray<NSString *> *segItems;
    UISegmentedControl *segView;
    UILabel *typeLabel;
    UILabel *dateLabel;
    
    NSInteger selectActicleId;
    NSString *category;
//    NSString *type;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

    UINavigationItem *item = self.navigationItem;
    item.title = @"SPONSORED CONTENT";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];

    
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 145;
    
    NSArray *ls = [Proto listArticle];
    self.items = ls;
    category=@"LATEST";
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)makeHeaderView2 {
    UIView *seg = [self makeSegPanel];
    seg.frame = makeRect(0, 0, SCREENWIDTH, 51);
    return seg;
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
    
    UIView *seg = [self makeSegPanel];
    [panel addSubview:seg];
    [[[[[seg.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];
    
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
}

- (void)clickCloseAd:(id)sender {
    self.table.tableHeaderView = [self makeHeaderView2];
}

- (Class)viewClassOfItem:(NSObject *)item {
    return GSKItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    return 145;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    GSKItemView *itemView = (GSKItemView *) view;
    itemView.delegate=self;
    [itemView bind:art];
}

- (void)onClickItem:(NSObject *)item {
    
    CMSDetailViewController *detail = [CMSDetailViewController new];
    detail.articleInfo = (Article *) item;
    [self.navigationController.tabBarController presentViewController:detail animated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"offfsize=%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat height=scrollView.contentSize.height>self.table.frame.size.height?self.table.frame.size.height:scrollView.contentSize.height;
    if((-scrollView.contentOffset.y/self.table.frame.size.height)>0.2){
        self.table.tableHeaderView = [self makeHeaderView];
        segView.selectedSegmentIndex=0;
    }
}



-(void)articleMoreAction:(NSInteger)articleid
{
    selectActicleId=articleid;
    NSLog(@"ArticleMoreAction=%@",@(articleid));
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show];
}

-(void)articleMarkAction:(NSInteger)articleid
{
    selectActicleId=articleid;
    NSLog(@"ArticleMarkAction=%@",@(articleid));
    if ([Proto checkIsBookmarkByArticle:articleid]) {
        //移除bookmark
        [Proto deleteBookmarks:articleid];
//        self.items=[Proto getArticleListByCategory:category type:type];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Delete" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        //添加bookmark
        [Proto addBookmarks:articleid];
//        self.items=[Proto getArticleListByCategory:category type:type];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Add" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
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


@end

