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
#import "DentistTabView.h"
#import "CMSModel.h"
#import "IdName.h"
#import "ArticleGSkItemView.h"
#import "CmsArticleCategoryPage.h"
#import "GSKViewController.h"
#import "DetinstDownloadManager.h"

@interface CmsForYouPage()<ArticleItemViewDelegate,MyActionSheetDelegate,DentistTabViewDelegate>
@end
@implementation CmsForYouPage {
	NSMutableArray<NSString *> *segItems;
    NSMutableArray<IdName *> *segItemsModel;
	UISegmentedControl *segView;
    UIView *panel;
    BannerScrollView *iv;
    BOOL isdeletead;
    NSString *selectActicleId;
    NSArray *dataArray;
    NSString *category;
    NSString *contenttype;
    DentistTabView *tabView;
    BOOL isdownrefresh;
    CMSModel *selectModel;
}
- (instancetype)init {
	self = [super init];
	self.topOffset = 0;
//    segItems = [NSMutableArray arrayWithArray:@[@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"]];
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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.items = [Proto getArticleListByCategory:category type:type];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    category=@"LATEST";
	UINavigationItem *item = [self navigationItem];
    //219*43
    //
    CGFloat imageheight=20;
    CGFloat imagewidth=219.0/43.0*imageheight;
    UIView *titleview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, imagewidth+20, 40)];
    UIImageView *imageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dsodentist"]];
    imageview.frame=CGRectMake(10, 10, imagewidth, imageheight);
    [titleview addSubview:imageview];
    item.titleView=titleview;
//    item.title = @"DSODENTIST";
	//TODO 还不太明白为啥 不设置rightBarButtonItem，title不显示
//    item.rightBarButtonItem = [self navBarText:@"test" target:self action:@selector(clickTest:)];
//    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];

	self.table.tableHeaderView = [self makeHeaderView];
	self.table.rowHeight = UITableViewAutomaticDimension;
	self.table.estimatedRowHeight = 500;
    self.isRefresh=YES;
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.items = [Proto getArticleListByCategory:category type:type];
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
    
//    UIView *seg = [self makeSegPanel];
//    [panel addSubview:seg];
//
//    [[[[[seg.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];
    
    
    tabView=[DentistTabView new];
    tabView.delegate=self;
    [panel addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];
//    tabView.modelArr=segItemsModel;

	return panel;
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
    tabView.modelArr=segItemsModel;
//    tabView.titleArr=segItems;//
    
    return headerview;
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
    contenttype=nil;
	NSInteger n = segView.selectedSegmentIndex;
    
	category = segItems[n];
    
    
	Log(@(n ), category);
//    self.items=[Proto getArticleListByCategory:category type:contenttype];
//    if (n!=0) {
//        CGFloat segw;
//        segw=SCREENWIDTH*2/7.0;
//        [segItems removeObjectAtIndex:n];
//        [segItems insertObject:category atIndex:0];
//        [segView removeSegmentAtIndex:n animated:NO];
//        [segView insertSegmentWithTitle:category atIndex:0 animated:NO];
//        [segView setWidth:segw forSegmentAtIndex:0];
//        segView.selectedSegmentIndex=0;
//    }
    
//    [segView removeSegmentAtIndex:n animated:YES];
//    [segView insertSegmentWithImage:[UIImage imageNamed:@"seg-sel"] atIndex:0 animated:YES];
    
    
    
    UIScrollView *segscrollView=(UIScrollView *)segView.superview;
    [segscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //
    CGFloat segw;
    segw=SCREENWIDTH*2/7.0;
//    CGFloat leftsegpoint=n*segw+segw/2.0;
//    //left
//    CGFloat leftspace=(leftsegpoint-SCREENWIDTH/2.0);
//    if (leftspace>0) {
//        //right
//        CGFloat rightsegpoint=segscrollView.contentSize.width-leftsegpoint;
//        CGFloat rightspace=(rightsegpoint-SCREENWIDTH/2.0);
//        if (rightspace<=0) {
//            CGFloat rightbottomoffset=segscrollView.contentSize.width-segscrollView.bounds.size.width;
//            [segscrollView setContentOffset:CGPointMake(rightbottomoffset, 0) animated:YES];
//        }else{
//            //left
//            [segscrollView setContentOffset:CGPointMake(leftspace, 0) animated:YES];
//        }
//    }else if (leftspace<=0) {
//        [segscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
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
    isdeletead=YES;
	self.table.tableHeaderView = [self makeHeaderView2];
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
//	return 430;
	return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
//    Article *art = (id) item;
//    ArticleItemView *itemView = (ArticleItemView *) view;
//    itemView.delegate=self;
//    [itemView bind:art];
//    CMSModel *model = (id) item;
//    if (![NSString isBlankString:model.sponsorId] && ([[model.sponsorId lowercaseString] isEqualToString:@"nobel"] || [[model.sponsorId lowercaseString] isEqualToString:@"gsk"] || [[model.sponsorId lowercaseString] isEqualToString:@"aln"])) {
//        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
//        itemView.delegate=self;
//        [itemView bindCMS:model];
//    }else{
//        ArticleItemView *itemView = (ArticleItemView *) view;
//        itemView.delegate=self;
//        [itemView bindCMS:model];
//    }
    
   

//    if (![NSString isBlankString:model.sponsorId] && ([model.sponsorId isEqualToString:@"260"] || [model.sponsorId isEqualToString:@"259"] || [model.sponsorId isEqualToString:@"197"])) {
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

-(void)getContentCachesData:(NSInteger)page{
    if (page==0) {
        NSMutableDictionary *newparadic=[NSMutableDictionary dictionary];
        if (self->contenttype) {
            [newparadic setObject:self->contenttype forKey:@"contentTypeId"];
        }
        NSString *keypara=jsonBuild(newparadic);
        NSString *cacheskey=[NSString stringWithFormat:@"%@_%@",@"findAllContents",keypara];
        [[DentistDataBaseManager shareManager] queryAllContentsCaches:cacheskey completed:^(NSArray<CMSModel *> * _Nonnull array) {
            if (array && array.count>=0) {
                foreTask(^() {
                    self.items=array;
                });
            }
        }];
    }
}


//MARK:刷新数据
-(void)refreshData
{
    category=@"LATEST";
    contenttype=nil;
    segView.selectedSegmentIndex=0;
    self.table.tableHeaderView = [self makeHeaderView];
    [self showIndicator];
    [self getContentCachesData:0];
    [Proto queryContentTypes:^(NSArray<IdName *> *array) {
        self->segItemsModel=[NSMutableArray arrayWithArray:array];
        IdName *latestmodel=[IdName new];
        latestmodel.id=@"0";
        latestmodel.name=@"LATEST";
        [self->segItemsModel insertObject:latestmodel atIndex:0];
        self->contenttype=nil;
        foreTask(^() {
            self->tabView.modelArr=self->segItemsModel;
        });

        [Proto queryAllContentsByContentType:self->contenttype skip:0 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                if (array && array.count>0) {
                    self.items=array;
                }
                
            });
        }];
    }];
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

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
////    NSLog(@"offfsize=%@",NSStringFromCGPoint(scrollView.contentOffset));
//    CGFloat height=scrollView.contentSize.height>self.table.frame.size.height?self.table.frame.size.height:scrollView.contentSize.height;
//    if((-scrollView.contentOffset.y/self.table.frame.size.height)>0.2){
//        category=@"LATEST";
//        type=nil;
//        segView.selectedSegmentIndex=0;
//        self.table.tableHeaderView = [self makeHeaderView];
//        self.items=[Proto getArticleListByCategory:category type:type];
//    }
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
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id completed:^(BOOL result) {
            foreTask(^() {
                
                NSString *msg=@"";
                if (result) {
                    //
                    model.isBookmark=NO;
                    if (![NSString isBlankString:model.sponsorId]) {
                        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                        [itemView updateBookmarkStatus:NO];
                    }else{
                        ArticleItemView *itemView = (ArticleItemView *) view;
                        [itemView updateBookmarkStatus:NO];
                    }
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
                    if (![NSString isBlankString:model.sponsorId]) {
                        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                        [itemView updateBookmarkStatus:YES];
                    }else{
                        ArticleItemView *itemView = (ArticleItemView *) view;
                        [itemView updateBookmarkStatus:YES];
                    }
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

-(void)ArticleGSKActionModel:(CMSModel *)model
{
//    GSKViewController *gskVC = [GSKViewController new];
//    gskVC.sponsorId=model.sponsorId;
//    [self.navigationController pushViewController:gskVC animated:YES];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    GSKViewController *gskVC = [GSKViewController new];
    gskVC.sponsorId=model.sponsorId;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:gskVC];
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            //添加
//            [Proto addDownload:selectActicleId];
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

-(void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName
{
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CmsArticleCategoryPage *newVC = [[CmsArticleCategoryPage alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    
    newVC.categoryId=categoryId;
    newVC.categoryName=categoryName;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

#pragma mark -------DentistTabViewDelegate
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    if (segItemsModel.count>index) {
        IdName *model=segItemsModel[index];
        Log(model.id, model.name);
        [self showIndicator];
        if ([model.id isEqualToString:@"0"]) {
            self->contenttype=nil;
        }else{
            self->contenttype=model.id;
        }
        [self getContentCachesData:0];
        [Proto queryAllContentsByContentType:self->contenttype skip:0 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                if (array && array.count>0) {
                    self.items=array;
                }
                
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
        if (!isdownrefresh) {
            isdownrefresh=YES;
            //在最底部
            [self showIndicator];
            [Proto queryAllContentsByContentType:self->contenttype skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
                self->isdownrefresh=NO;
                foreTask(^() {
                    [self hideIndicator];
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
