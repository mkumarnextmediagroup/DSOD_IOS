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

@implementation CmsForYouPage {
	NSArray<NSString *> *segItems;
	UISegmentedControl *segView;
}
- (instancetype)init {
	self = [super init];
	self.topOffset = 0;
	segItems = @[@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEW", @"TECH GUIDE", @"ANIMATIONS", @"TIP SHEETS"];
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
	item.rightBarButtonItem = [self navBarText:@"test" target:self action:@selector(clickTest:)];


	self.table.tableHeaderView = [self makeHeaderView];
	self.table.rowHeight = UITableViewAutomaticDimension;
	self.table.estimatedRowHeight = 400;

	NSArray *ls = [Proto listArticle];
	self.items = ls;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationItem.title = @"DSODENTIST";
}


- (UIView *)makeHeaderView {
	UIView *panel = [UIView new];
	panel.frame = makeRect(0, 0, SCREENWIDTH, 211);
	UIImageView *iv = [panel addImageView];
	[iv scaleFillAspect];
	iv.imageName = @"ad";
	[[[[[[iv layoutMaker] leftParent:0] rightParent:0] topParent:0] heightEq:160] install];

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
	CMSDetailViewController *detail = [CMSDetailViewController new];
	detail.articleInfo = (Article *) item;
	[self.navigationController.tabBarController presentViewController:detail animated:YES completion:nil];
}


@end
