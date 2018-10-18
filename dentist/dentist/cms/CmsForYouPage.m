//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsForYouPage.h"
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

@interface CmsForYouPage()<ArticleItemViewDelegate,MyActionSheetDelegate>
@end
@implementation CmsForYouPage {
	NSArray<NSString *> *segItems;
	UISegmentedControl *segView;
    UIView *panel;
    BannerScrollView *iv;
    BOOL isdeletead;
    NSInteger selectActicleId;
    NSArray *dataArray;
    NSString *category;
    NSString *type;
    UISegmentedControl *seg;
}
- (instancetype)init {
	self = [super init];
	self.topOffset = 0;
	segItems = @[@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"];
//    //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
//    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
//        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    }
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
//                                                name:UIDeviceOrientationDidChangeNotification object:nil];
	return self;
}

- (void)clickTest:(id)sender {
	UIViewController *c = [TestPage new];
	[self pushPage:c];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.items = [Proto getArticleListByCategory:category type:type];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    category=@"LATEST";
	UINavigationItem *item = [self navigationItem];
	item.title = @"DSODENTIST";
	//TODO 还不太明白为啥 不设置rightBarButtonItem，title不显示
//    item.rightBarButtonItem = [self navBarText:@"test" target:self action:@selector(clickTest:)];
    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];

	self.table.tableHeaderView = [self makeHeaderView];
	self.table.rowHeight = UITableViewAutomaticDimension;
	self.table.estimatedRowHeight = 400;
	self.items = [Proto getArticleListByCategory:category type:type];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationItem.leftBarButtonItem = [self menuButton];
//}

//- (UIBarButtonItem *)menuButton {
//    return [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenu:)];
//}

- (UIView *)makeHeaderView {
	panel = [UIView new];
    CGFloat bannerh=(396.0/718.0*SCREENWIDTH);
	panel.frame = makeRect(0, 0, SCREENWIDTH, bannerh+51);
//    UIImageView *iv = [panel addImageView];
//    [iv scaleFillAspect];
//    iv.imageName = @"ad";
//    [[[[[[iv layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:160] install];
//
//    UIButton *tapad=[panel addButton];
//    [[[[[[tapad layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:160] install];
//    [tapad addTarget:self action:@selector(showImageBrowser) forControlEvents:UIControlEventTouchUpInside];
//
    //718*396;
    
    NSArray *urls = @[
                      @"slide-1",
                      @"slide-2",
                      @"slide-3",
                      @"slide-4",
                      @"slide-5"];
    iv =[BannerScrollView new];
    [panel addSubview:iv];
    typeof(self) __weak weakself = self;
    [[[[[[iv layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:bannerh] install];
    [iv addWithImageNames:urls autoTimerInterval:3 clickBlock:^(NSInteger index) {
        NSLog(@"index=%@",@(index));
        //可以做点击处理
//        [weakself showImageBrowser:index-1];
    }];
    
    UIButton *closeAd = [panel addButton];
    [closeAd setImage:[UIImage imageNamed:@"close-white"] forState:UIControlStateNormal];
    [[[[closeAd.layoutMaker topParent:22] rightParent:-22] sizeEq:24 h:24] install];
    [closeAd onClick:self action:@selector(clickCloseAd:)];
    
    UIView *seg = [self makeSegPanel];
    [panel addSubview:seg];
    [[[[[seg.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];

	return panel;
}

- (UIView *)makeHeaderView2 {
	UIView *seg = [self makeSegPanel];
	seg.frame = makeRect(0, 0, SCREENWIDTH, 51);
	return seg;
}

- (UIView *)makeSegPanel {
    CGFloat segw;
    segw=SCREENWIDTH*2/7.0;
	seg = [[UISegmentedControl alloc] initWithItems:segItems];
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
    type=nil;
	NSInteger n = segView.selectedSegmentIndex;
	category = segItems[n];
	Log(@(n ), category);
    self.items=[Proto getArticleListByCategory:category type:type];
    
}

- (void)clickCloseAd:(id)sender {
    isdeletead=YES;
	self.table.tableHeaderView = [self makeHeaderView2];
}

- (Class)viewClassOfItem:(NSObject *)item {
	return ArticleItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
//	return 430;
	return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
	Article *art = (id) item;
	ArticleItemView *itemView = (ArticleItemView *) view;
    itemView.delegate=self;
	[itemView bind:art];
}

- (void)onClickItem:(NSObject *)item {
    
//    CMSDetailViewController *detail = [CMSDetailViewController new];
//    detail.articleInfo = (Article *) item;
//    [self.navigationController.tabBarController presentViewController:detail animated:YES completion:nil];

    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    newVC.articleInfo = (Article *) item;
    if ([newVC.articleInfo.category isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

-(void)showImageBrowser:(NSInteger)index
{
    NSInteger tempindex;
    
    NSArray *dataArray = @[
                       @"https://www.dsodentist.com/assets/images/slide/slide-1.jpg",
                       @"https://www.dsodentist.com/assets/images/slide/slide-2.jpg",
                       @"https://www.dsodentist.com/assets/images/slide/slide-3.jpg",
                       @"https://www.dsodentist.com/assets/images/slide/slide-4.jpg",
                       @"https://www.dsodentist.com/assets/images/slide/slide-5.jpg"];
    if (index>0 && index <dataArray.count) {
        tempindex=index;
    }
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:urlStr];
        [browserDataArr addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    DentistImageBrowserToolBar *toolBar = [DentistImageBrowserToolBar new];
    toolBar.detailArray=@[@"Welcome",@"Reduce Plaque and Gingivitis",@"Today's Peer to Peer community...",@"Understanding the DSO Practice Model",@"All the support I need..."];
    browser.toolBars = @[toolBar];
    browser.sheetView = nil;
    [browser show];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"offfsize=%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat height=scrollView.contentSize.height>self.table.frame.size.height?self.table.frame.size.height:scrollView.contentSize.height;
    if((-scrollView.contentOffset.y/self.table.frame.size.height)>0.2){
        category=@"LATEST";
        type=nil;
        seg.selectedSegmentIndex=1;
        self.table.tableHeaderView = [self makeHeaderView];
        self.items=[Proto getArticleListByCategory:category type:type];
    }
}


-(void)ArticleMoreAction:(NSInteger)articleid
{
    selectActicleId=articleid;
    NSLog(@"ArticleMoreAction=%@",@(articleid));
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show];
}

-(void)ArticleMarkAction:(NSInteger)articleid
{
    selectActicleId=articleid;
    NSLog(@"ArticleMarkAction=%@",@(articleid));
    if ([Proto checkIsBookmarkByArticle:articleid]) {
        //移除bookmark
        [Proto deleteBookmarks:articleid];
        self.items=[Proto getArticleListByCategory:category type:type];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Bookmarks is Delete" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        //添加bookmark
        [Proto addBookmarks:articleid];
        self.items=[Proto getArticleListByCategory:category type:type];
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

-(void)CategoryPickerSelectAction:(NSString *)result
{
    type=result;
    self.items=[Proto getArticleListByCategory:category type:type];
}

@end
