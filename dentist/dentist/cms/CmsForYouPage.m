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
#import "DentistDownloadManager.h"
#import "DentistPickerView.h"
#import "DsoToast.h"

@interface CmsForYouPage()<ArticleItemViewDelegate,MyActionSheetDelegate,DentistTabViewDelegate>
@end
@implementation CmsForYouPage {
    UIView *panel;
    BannerScrollView *iv;
    BOOL isdeletead;
    NSString *selectActicleId;
    NSArray *dataArray;
    DentistTabView *tabView;
    BOOL isdownrefresh;
}
- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.table reloadData];
    //    self.items = [Proto getArticleListByCategory:category type:type];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _category=@"LATEST";
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
}

#pragma mark ----Public method

/**
 cms Cache data
 */
-(void)getContentCachesData:(NSInteger)page {
    if (page==0) {
        NSMutableDictionary *newparadic=[NSMutableDictionary dictionary];
        if (self->_contenttype) {
            [newparadic setObject:self->_contenttype forKey:@"contentTypeId"];
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


/**
 查询cms列表数据
 query cms list data
 */
-(void)refreshData
{
    _category=@"LATEST";
    _contenttype=nil;
    _segView.selectedSegmentIndex=0;
    self.table.tableHeaderView = [self makeHeaderView];
    [self showIndicator];
    [self getContentCachesData:0];
    [Proto queryContentTypes:^(NSArray<IdName *> *array) {
        self->_segItemsModel=[NSMutableArray arrayWithArray:array];
        IdName *latestmodel=[IdName new];
        latestmodel.id=@"0";
        latestmodel.name=@"LATEST";
        [self->_segItemsModel insertObject:latestmodel atIndex:0];
        //"31"
        __block NSInteger sponsorindex;
        [self->_segItemsModel enumerateObjectsUsingBlock:^(IdName * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.id isEqualToString:@"31"]) {
                sponsorindex=idx;
                *stop=YES;
            }
        }];
        if(self->_segItemsModel.count>sponsorindex){
            IdName *latestmodel=[IdName new];
            latestmodel.id=@"-1";
            latestmodel.name=@" SPONSORED";
            [self->_segItemsModel insertObject:latestmodel atIndex:sponsorindex];
        }
        self->_contenttype=nil;
        foreTask(^() {
            self->tabView.modelArr=self->_segItemsModel;
        });
        
        [Proto queryAllContentsByContentType:self->_contenttype skip:0 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                if (array && array.count>0) {
                    self.items=array;
                }
                
            });
        }];
    }];
}

/**
 表头视图
 table Header View
 */
- (UIView *)makeHeaderView {
    panel = [UIView new];
    CGFloat bannerh=(396.0/718.0*SCREENWIDTH);
    panel.frame = makeRect(0, 0, SCREENWIDTH, bannerh+51);
    
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
    
    
    tabView=[DentistTabView new];
    tabView.delegate=self;
    [panel addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] below:iv offset:0] heightEq:51] install];
    //    tabView.modelArr=segItemsModel;

    return panel;
}

/**
 表头视图
 table Header View
 */
- (UIView *)makeHeaderView2 {
    UIView *headerview = [UIView new];
    headerview.frame = makeRect(0, 0, SCREENWIDTH, 51);
    [headerview addSubview:tabView];
    tabView=[DentistTabView new];
    tabView.delegate=self;
    [headerview addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:51] install];
    tabView.modelArr=_segItemsModel;
    
    return headerview;
}

/**
 show slide list images
 */
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

/**
 关闭广告
 close ad event
 */
- (void)clickCloseAd:(id)sender {
    isdeletead=YES;
    self.table.tableHeaderView = [self makeHeaderView2];
}

#pragma mark ----table method
/**
 table cell class
 */
- (Class)viewClassOfItem:(NSObject *)item {
    //    CMSModel *model = (id) item;
    //    if (![NSString isBlankString:model.sponsorId]) {
    //        return ArticleGSkItemView.class;
    //    }else{
    //        return ArticleItemView.class;
    //    }
    return ArticleGSkItemView.class;
}

/**
 table cell height
 */
- (CGFloat)heightOfItem:(NSObject *)item {
    //	return 430;
    return UITableViewAutomaticDimension;
}

/**
 table cell view
 */
- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    CMSModel *model = (id) item;
    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:model];
}

/**
 click table cell event；click it，go to article detail page
 */
- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    CMSModel *article = (CMSModel *) item;
    newVC.contentId = article.id;
    newVC.cmsmodelsArray=self.items;
    newVC.modelIndexOfArray = (int)indexPath.row;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

#pragma mark -------ArticleItemViewDelegate
/**
 Article more items Action,update & share
 */
-(void)ArticleMoreActionModel:(CMSModel *)model
{
    _selectModel=model;
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

/**
 Article bookmark event; add & delete
 */
-(void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view
{
    CMSModel *model = (id) item;
    if(model.isBookmark){
        //删除
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from bookmarks……" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id completed:^(HttpResult *result) {
            foreTask(^() {
                [self handleDeleteBookmark:result model:model view:view];
            });
        }];
    }else{
        //添加
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Saving to bookmarks…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto addBookmark:getLastAccount() cmsmodel:model completed:^(HttpResult *result) {
            foreTask(^() {
                [self handleAddBookmark:result model:model view:view];
            });
        }];
    }
}

/**
 Article bookmark delete event
 */
- (void) handleDeleteBookmark:(HttpResult *)result model:(CMSModel *)model view:(UIView *)view {
    [self.navigationController.view hideToast];
    if (result.OK) {
        //
        model.isBookmark=NO;
        if (![NSString isBlankString:model.sponsorId]) {
            ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
            [itemView updateBookmarkStatus:NO];
        }else{
            ArticleItemView *itemView = (ArticleItemView *) view;
            [itemView updateBookmarkStatus:NO];
        }
    }else{
        NSString *message=result.msg;
        if([NSString isBlankString:message]){
            message=@"Failed";
        }
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window makeToast:message
                 duration:1.0
                 position:CSToastPositionBottom];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 Article bookmark add event
 */
- (void) handleAddBookmark:(HttpResult *)result model:(CMSModel *)model view:(UIView *)view {
    [self.navigationController.view hideToast];
    if (result.OK) {
        //
        model.isBookmark=YES;
        if (![NSString isBlankString:model.sponsorId]) {
            ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
            [itemView updateBookmarkStatus:YES];
        }else{
            ArticleItemView *itemView = (ArticleItemView *) view;
            [itemView updateBookmarkStatus:YES];
        }
    }else{
        if(result.code==2033){
            model.isBookmark=YES;
            if (![NSString isBlankString:model.sponsorId]) {
                ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                [itemView updateBookmarkStatus:YES];
            }else{
                ArticleItemView *itemView = (ArticleItemView *) view;
                [itemView updateBookmarkStatus:YES];
            }
        }else{
            NSString *message=result.msg;
            if([NSString isBlankString:message]){
                message=@"Failed";
            }
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [window makeToast:message
                     duration:1.0
                     position:CSToastPositionBottom];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

/**
 go to Sponsor Article page
 */
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

/**
download & share event
 */
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            //添加
            //            [Proto addDownload:selectActicleId];
            if (_selectModel) {
                UIView *dsontoastview=[DsoToast toastViewForMessage:@"Download is Add…" ishowActivity:YES];
                [self.navigationController.view showToast:dsontoastview duration:1.0 position:CSToastPositionBottom completion:nil];
                [[DentistDownloadManager shareManager] startDownLoadCMSModel:_selectModel addCompletion:^(BOOL result) {
                } completed:^(BOOL result) {}];
            }
        }
            break;
        case 1://---click the Share button
        {
            NSLog(@"Share click");
            if (_selectModel) {
                NSString *urlstr=@"";
                NSString *title=[NSString stringWithFormat:@"%@",_selectModel.title];
                NSString* type = _selectModel.featuredMedia[@"type"];
                if([type isEqualToString:@"1"] ){
                    //pic
                    NSDictionary *codeDic = _selectModel.featuredMedia[@"code"];
                    urlstr = codeDic[@"thumbnailUrl"];
                }else{
                    urlstr = _selectModel.featuredMedia[@"code"];
                }
                NSString *someid=_selectModel.id;
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
            } else {
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

/**
 go to Article Category  page
 */
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
/**
Category items select action
 */
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    if (_segItemsModel.count>index) {
        IdName *model=_segItemsModel[index];
        Log(model.id, model.name);
        if ([model.id isEqualToString:@"-1"]) {
            //供应商选择器
            IdName *align=[[IdName alloc] init];
            align.id=@"260";
            align.name=@"Align Technology";
            IdName *gsk=[[IdName alloc] init];
            gsk.id=@"197";
            gsk.name=@"GlaxoSmithKline";
            IdName *nobel=[[IdName alloc] init];
            nobel.id=@"259";
            nobel.name=@"Nobel Biocare";
            DentistPickerView *picker = [[DentistPickerView alloc]init];
            picker.arrayDic=@[align,gsk,nobel];
            picker.leftTitle=localStr(@"");
            picker.righTtitle=localStr(@"OK");
            [picker show:^(NSString *result,NSString *resultname) {
            } rightAction:^(NSString *result,NSString *resultname) {
                [self handlePicker:result resultName:resultname];
            } selectAction:^(NSString *result,NSString *resultname) {}];
        }else{
            [self showIndicator];
            if ([model.id isEqualToString:@"0"]) {
                self->_contenttype=nil;
            } else {
                self->_contenttype=model.id;
            }
            [self getContentCachesData:0];
            [Proto queryAllContentsByContentType:self->_contenttype skip:0 completed:^(NSArray<CMSModel *> *array) {
                foreTask(^() {
                    [self hideIndicator];
                    if (array && array.count>0) {
                        self.items=array;
                    }
                });
            }];
        }
    }
}

/**
 go to Sponsor Article page
 */
-(void)handlePicker:(NSString *)result resultName:(NSString *)resultname {
    NSLog(@"供应商==%@;name=%@",result,resultname);
    if (result) {
        UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        GSKViewController *gskVC = [GSKViewController new];
        gskVC.sponsorId=result;
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:gskVC];
        [viewController presentViewController:navVC animated:YES completion:NULL];
    }
}

/**
 load more data
 */
-(void)loadMore {
    if (!isdownrefresh) {
        isdownrefresh=YES;
        //在最底部
        [self showIndicator];
        [Proto queryAllContentsByContentType:self->_contenttype skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50) {
        [self loadMore];
    }
}

@end
