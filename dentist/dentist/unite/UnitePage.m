//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UnitePage.h"
#import "Common.h"
#import "UnitePageCell.h"
#import "Proto.h"
#import "UniteDetailViewController.h"
#import "YHPopMenuView.h"
#import "UniteDownloadingViewController.h"
#import "dentist-Swift.h"
#import "ThumAndDetailViewController.h"
#import "DentistDataBaseManager.h"
#import "MagazineModel.h"

@interface UnitePage()<UITableViewDelegate,UITableViewDataSource,ThumViewControllerDelegate>{
    UITableView *mTableView;
    UIActivityIndicatorView *iv;
    
    YHPopMenuView *popView;
    
    NSArray *datas;
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
    
    BOOL onlyDownloadedUinte;
    
}
@end

@implementation UnitePage

- (void)addNotification
{
    // 状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:DentistUniteDownloadStateChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(archiveChange:) name:DentistUniteArchiveChangeNotification object:nil];
}

- (void)downLoadStateChange:(NSNotification *)notification
{
    MagazineModel *downloadModel = notification.object;
    NSMutableArray *tempArr=[NSMutableArray arrayWithArray:self->datas];
    [tempArr enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: [MagazineModel class]]) {
            MagazineModel *model=(MagazineModel *)obj;
            if ([downloadModel._id isEqualToString:model._id]) {
                // 更新数据源
                tempArr[idx] = downloadModel;
                self->datas=[tempArr copy];
                // 主线程刷新cell
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self->mTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                });
                
                *stop = YES;
            }
        }
        
    }];
}

-(void)archiveChange:(NSNotification *)notification{
    NSString *uniteid=notification.object;
    NSMutableArray *tempArr=[NSMutableArray arrayWithArray:self->datas];
    [tempArr enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: [MagazineModel class]]) {
            MagazineModel *model=(MagazineModel *)obj;
            if ([uniteid isEqualToString:model._id]) {
                // 更新数据源
                model.downstatus=@"0";
                self->datas=[tempArr copy];
                // 主线程刷新cell
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self->mTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                });
                
                *stop = YES;
            }
        }
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigation];
    
    mTableView = [UITableView new];
    mTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTableView.dataSource = self;
    mTableView.delegate = self;
    [self.view addSubview:mTableView];
    [mTableView layoutFill];
    
    [self setupRefresh];
    [self addNotification];
    //测试
//    [[DentistDataBaseManager shareManager] updateUniteArticleBookmark:@"5be5df7f5a71b7249c07e064" isbookmark:1 completed:^(BOOL result) {
//        if (result) {
//            [[DentistDataBaseManager shareManager] queryUniteArticlesBookmarkCachesList:^(NSArray<DetailModel *> * _Nonnull array) {
//                if (array) {
//                    
//                }
//            }];
//        }
//    }];
//    
//    [[DentistDataBaseManager shareManager] archiveUnite:@"5bd7fedf2676fdc2e88b5494" completed:^(BOOL result) {
//        if (result) {
//            [[DentistDataBaseManager shareManager] queryUniteArticlesCachesList:@"5bd7fedf2676fdc2e88b5494" completed:^(NSArray<DetailModel *> * _Nonnull array) {
//                if (array) {
//
//                }
//                [[DentistDataBaseManager shareManager] queryUniteArticlesCachesByKeywordList:@"5bd7fedf2676fdc2e88b5494" keywords:@"Interproximal Reduction (IPR)" completed:^(NSArray<DetailModel *> * _Nonnull array) {
//                    if (array) {
//
//                    }
//                }];
//            }];
//            [[DentistDataBaseManager shareManager] queryUniteArticlesBookmarkCachesList:^(NSArray<DetailModel *> * _Nonnull array) {
//                if (array) {
//                    
//                }
//            }];
//        }
//    }];
   
}

-(void)setupNavigation{
    UINavigationItem *item = [self navigationItem];
    item.title = @"All ISSUES";
    
    
    iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    iv.tag = 998;
    iv.backgroundColor = [UIColor clearColor];
    iv.center = item.rightBarButtonItem.customView.center;
    UIBarButtonItem *ivItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setImage:[UIImage imageNamed:@"FilterIssues"] forState:UIControlStateNormal];
    [menuBtn sizeToFit];
    UIBarButtonItem *menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
    self.navigationItem.rightBarButtonItems  = @[menuBtnItem,fixedSpaceBarButtonItem,ivItem];
    
}

- (void)enterTeamCard:(MagazineModel *)model
{
    ThumViewController *thumvc=[ThumViewController new];
    thumvc.magazineModel = model;
    thumvc.uniteid=model._id;
    [self.navigationController pushViewController:thumvc animated:YES];
    
}

- (void)enterUniteDownloading:(MagazineModel*) model{
    UniteDownloadingViewController *vc = [[UniteDownloadingViewController alloc]init];
    vc.magazineModel = model;
    vc.datas = datas;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [mTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    [self firstRefresh];

}


- (void)showTopIndicator {
    iv.hidden = NO;
    [iv startAnimating];
    isRefreshing = YES;
}

- (void)hideTopIndicator {
    iv.hidden = YES;
    [iv stopAnimating];
    isRefreshing = NO;
}


-(void)firstRefresh{
     [self getDatas:NO];
     [refreshControl endRefreshing];
}


-(void)getDatas:(BOOL)isMore{
    if(isRefreshing){
        return;
    }
    
    if(onlyDownloadedUinte){
        return;
    }
    
    [self showTopIndicator];
    backTask(^{
        NSArray *arr = [Proto findAllMagazines:isMore?self->datas.count:0];
        foreTask(^{
            [self hideTopIndicator];
            [self reloadData:[arr copy]  isMore:isMore];
        });
    });
}

-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(newDatas!=nil && newDatas.count >0){
        if(isMore){
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:datas];
            [mutableArray addObjectsFromArray:newDatas];
            datas = [mutableArray copy];
        }else{
            datas = newDatas;
        }
        //TODO False data
        if(datas.count>0){
        ((MagazineModel*)datas[0]).cover = @"http://pic41.photophoto.cn/20161202/1155116460723923_b.jpg";
//        ((MagazineModel*)datas[1]).cover = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542037826&di=64e2e24bf769d5c2b71d7372a0515d7d&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3Dec50dee888025aafc73f76889384c111%2Fa50f4bfbfbedab643e0cd5e8fd36afc379311e9f.jpg";
        }
        
        [mTableView reloadData];
    }
}

-(void)gotoThumView:(NSInteger)row
{
    if (self->datas.count>=1) {
        MagazineModel *model=(MagazineModel *)self->datas[0];
        ThumViewController *thumvc=[ThumViewController new];
        thumvc.magazineModel = model;
        thumvc.uniteid=model._id;
        thumvc.thumSelectMenu = ^(NSInteger row) {
            NSLog(@"thumDidSelectMenu==========%@",@(row));
        };
        //    thumvc.didSelectMenu =^(NSInteger index) {
        //
        //    }
        
        [self.navigationController pushViewController:thumvc animated:YES];
    }
    
}

-(void)startUniteDownload{
    
}

-(void)openMenu{
    if(popView && popView.isShowing){
        [popView hide];
        return;
    }
    
    CGFloat itemH = 50;
    CGFloat w = 200;
    CGFloat h = 3*itemH;
    CGFloat r = 0;
    CGFloat x = SCREENWIDTH - w - r;
    CGFloat y = 0;
    
    popView = [[YHPopMenuView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    popView.iconNameArray = @[@"arrow",@"arrow",@"arrow"];
    popView.itemNameArray = @[@"All Issues",@"Downloaded",@"Go to Bookmarks"];
    popView.itemH     = itemH;
    popView.fontSize  = 16.0f;
    popView.fontColor = [UIColor blackColor];
    popView.canTouchTabbar = YES;
    [popView show];
    
//    WeakSelf
    [popView dismissHandler:^(BOOL isCanceled, NSInteger row) {
        if (!isCanceled) {
            if(row == 0){
                [self showAllIssues];
            }else if(row == 1){
                [self showDownloaded];
            }else if(row == 2){
                ThumViewController *thumvc=[ThumViewController new];
                thumvc.pageType = PageTypeBookmark;
                [self.navigationController pushViewController:thumvc animated:YES];
            }
        }
    }];
    
}

-(void)showDownloaded{
    onlyDownloadedUinte = YES;
    UINavigationItem *item = [self navigationItem];
    item.title = @"DOWNLOADED";
    [[DentistDataBaseManager shareManager] queryUniteDownloadedList:^(NSArray<MagazineModel *> * _Nonnull array) {
        foreTask(^{
            self->datas=[NSArray arrayWithArray:array];
            [self->mTableView reloadData];
        });
    }];
     
}

-(void)showAllIssues{
    onlyDownloadedUinte = NO;
    UINavigationItem *item = [self navigationItem];
    item.title = @"All ISSUES";
    [self firstRefresh];
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREENWIDTH * 6 /5 + 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UnitePageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UnitePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.magazineModel = datas[indexPath.row];
//    cell.optonBtnOnClickListener = ^(UnitePageDownloadStatus status,MagazineModel *model){
//        switch (status) {
//            case UPageDownloaded:
//                //to detail page
//                [self enterTeamCard:nil];
//                break;
//            case UPageNoDownload:
//                //start download
//                [self startUniteDownload];
//                
//            case UPageDownloading:{
//                //to downloading page
//                [self enterUniteDownloading:model];
//                break;
//            }
//            default:
//                break;
//        }
//    };
    cell.optonBtnOnClickDownload = ^(NSInteger status, MagazineModel *model) {
        switch (status) {
            case 2:
                //to detail page
                [self enterTeamCard:model];
                break;
            case 0:
                //start download
                [self startUniteDownload];
                
            case 1:{
                //to downloading page
                [self enterUniteDownloading:model];
                break;
            }
            default:
                break;
        }
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self->datas.count>indexPath.row) {
        MagazineModel *magazineModel=self->datas[indexPath.row];
        [[DentistDataBaseManager shareManager] checkUniteStatus:magazineModel._id completed:^(NSInteger result) {
            NSLog(@"======下载状态=%@",@(result));
            foreTask(^{
                if (result==2) {
                    [self gotoThumView:indexPath.row];
                }
            });
            
        }];
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
}

-(void)thumDidSelectMenu:(NSInteger)index
{
    NSLog(@"thumDidSelectMenu3333==========%@",@(index));
}
@end
