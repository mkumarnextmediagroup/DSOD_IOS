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

@implementation CmsForYouPage {
	NSArray<NSString *> *segItems;
	UISegmentedControl *segView;
    UIView *panel;
    BannerScrollView *iv;
    BOOL isdeletead;
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

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = [self navigationItem];
	item.title = @"DSODENTIST";
	//TODO 还不太明白为啥 不设置rightBarButtonItem，title不显示
//    item.rightBarButtonItem = [self navBarText:@"test" target:self action:@selector(clickTest:)];
    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];

	self.table.tableHeaderView = [self makeHeaderView];
	self.table.rowHeight = UITableViewAutomaticDimension;
	self.table.estimatedRowHeight = 400;

	NSArray *ls = [Proto listArticle];
	self.items = ls;
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
//    UIButton *closeAd = [panel addButton];
//    [closeAd setImage:[UIImage imageNamed:@"close-white"] forState:UIControlStateNormal];
//    [[[[closeAd.layoutMaker topParent:22] rightParent:-22] sizeEq:24 h:24] install];
//    [closeAd onClick:self action:@selector(clickCloseAd:)];

    //718*396;
    
    NSArray *urls = @[
                      @"https://www.dsodentist.com/assets/images/slide/slide-1.jpg",
                      @"https://www.dsodentist.com/assets/images/slide/slide-2.jpg",
                      @"https://www.dsodentist.com/assets/images/slide/slide-3.jpg",
                      @"https://www.dsodentist.com/assets/images/slide/slide-4.jpg",
                      @"https://www.dsodentist.com/assets/images/slide/slide-5.jpg"];
    iv =[BannerScrollView new];
    [panel addSubview:iv];
    typeof(self) __weak weakself = self;
    [[[[[[iv layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:bannerh] install];
    [iv addWithImageUrls:urls autoTimerInterval:3 clickBlock:^(NSInteger index) {
        NSLog(@"index=%@",@(index));
        //可以做点击处理
        [weakself showImageBrowser:index-1];
    }];
   
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
	UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:segItems];
	UIImage *img = colorImage(makeSize(1, 1), rgba255(221, 221, 221, 100));
	[seg setDividerImage:img forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

	[seg setTitleTextAttributes:@{NSFontAttributeName: [Fonts semiBold:12], NSForegroundColorAttributeName: Colors.textMain} forState:UIControlStateNormal];
	[seg setTitleTextAttributes:@{NSFontAttributeName: [Fonts semiBold:12], NSForegroundColorAttributeName: Colors.textMain} forState:UIControlStateSelected];

	//colorImage(makeSize(1, 1), rgba255(247, 247, 247, 255))
	[seg setBackgroundImage:[UIImage imageNamed:@"seg-bg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[seg setBackgroundImage:[UIImage imageNamed:@"seg-sel"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
	for (NSUInteger i = 0; i < segItems.count; ++i) {
		[seg setWidth:90 forSegmentAtIndex:i];
	}
	seg.selectedSegmentIndex = 0;

	UIScrollView *sv = [UIScrollView new];
	[sv addSubview:seg];

	sv.contentSize = makeSize(90 * segItems.count, 50);
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


@end
