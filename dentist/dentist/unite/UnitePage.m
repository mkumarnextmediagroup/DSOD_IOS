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
@import Firebase;

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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryDownloadList];
    [FIRAnalytics setScreenName:@"UNITE_Page" screenClass:@"UniteView"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"getRectNavAndStatusHight====%@；IPHONE_X=%@",@(getRectNavAndStatusHight),@(IPHONE_X));
    [self setupNavigation];
    
    mTableView = [UITableView new];
    mTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTableView.dataSource = self;
    mTableView.delegate = self;
    [self.view addSubview:mTableView];
    [mTableView layoutFill];
    
    [self setupRefresh];
    [self addNotification];
}

#pragma mark ----Public method
/**
 query download unite list data
 */
-(void)queryDownloadList
{
    if (onlyDownloadedUinte) {
        UINavigationItem *item = [self navigationItem];
        item.title = @"DOWNLOADED";
        [[DentistDataBaseManager shareManager] queryUniteDownloadedList:^(NSArray<MagazineModel *> * _Nonnull array) {
            foreTask(^{
                self->datas=[NSArray arrayWithArray:array];
                [self->mTableView reloadData];
                //             [self->mTableView setContentOffset:CGPointMake(0, 0) animated:NO];
                if (self->datas.count>0) {
                    [self->mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
            });
        }];
    }
}
/**
 add the notification,when one download item state has changed，notification system to change the style of the view.
 */
- (void)addNotification
{
    // 状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:DentistUniteDownloadStateChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(archiveChange:) name:DentistUniteArchiveChangeNotification object:nil];
}

/**
 notification method,when one download item state has changed，this method will change the style of the view.
 */
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

/**
 notification method,when one archive item state has changed，this method will change the style of the view.
 */
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

/**
 set Navigation item
 */
-(void)setupNavigation{
    UINavigationItem *item = [self navigationItem];
    item.title = @"ALL ISSUES";
    
    
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

/**
 go to unite detail page
 */
- (void)enterTeamCard:(MagazineModel *)model
{
    ThumViewController *thumvc=[ThumViewController new];
    thumvc.magazineModel = model;
    thumvc.uniteid=model._id;
    [self.navigationController pushViewController:thumvc animated:YES];
    
}

/**
 go to unite downloading page
 */
- (void)enterUniteDownloading:(MagazineModel*) model{
    UniteDownloadingViewController *vc = [[UniteDownloadingViewController alloc]init];
    vc.magazineModel = model;
    vc.datas = datas;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 Pull down to refresh
 */
-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [mTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    [self firstRefresh];

}

/**
show the loading Animating
 */
- (void)showTopIndicator {
    iv.hidden = NO;
    [iv startAnimating];
    isRefreshing = YES;
}

/**
 hide the loading Animating
 */
- (void)hideTopIndicator {
    iv.hidden = YES;
    [iv stopAnimating];
    isRefreshing = NO;
}

/**
 end refreshing
 */
-(void)firstRefresh{
     [self getDatas:NO];
     [refreshControl endRefreshing];
    
}


/**
 query unite list data
 */
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

/**
 reload unite list data and display it in the tableview
 */
-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(newDatas!=nil && newDatas.count >0){
        if(isMore){
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:datas];
            [mutableArray addObjectsFromArray:newDatas];
            datas = [mutableArray copy];
        }else{
            datas = newDatas;
        }
        
        [mTableView reloadData];
        if (datas.count>0) {
            [self->mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}

/**
 go to unite detail page
 @param row which row in the unite list
 */
-(void)gotoThumView:(NSInteger)row
{
    if (self->datas.count>row) {
        MagazineModel *model=(MagazineModel *)self->datas[row];
        ThumViewController *thumvc=[ThumViewController new];
        thumvc.magazineModel = model;
        thumvc.uniteid=model._id;
        thumvc.thumSelectMenu = ^(NSInteger row) {
            NSLog(@"thumDidSelectMenu==========%@",@(row));
        };
        
        [self.navigationController pushViewController:thumvc animated:YES];
    }
    
}

-(void)startUniteDownload{
    
}

/**
 show the menu on the Upper right corner when click it.
 */
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

/**
 display the download unite list data
 */
-(void)showDownloaded{
    onlyDownloadedUinte = YES;
    UINavigationItem *item = [self navigationItem];
    item.title = @"DOWNLOADED";
    [[DentistDataBaseManager shareManager] queryUniteDownloadedList:^(NSArray<MagazineModel *> * _Nonnull array) {
        foreTask(^{
            self->datas=[NSArray arrayWithArray:array];
            [self->mTableView reloadData];
//             [self->mTableView setContentOffset:CGPointMake(0, 0) animated:NO];
            if (self->datas.count>0) {
                [self->mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        });
    }];
     
}

/**
 display all issues (unite list)
 */
-(void)showAllIssues{
    onlyDownloadedUinte = NO;
    UINavigationItem *item = [self navigationItem];
    item.title = @"All ISSUES";
    [self firstRefresh];
}



#pragma mark UITableViewDataSource & UITableViewDelegate
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
