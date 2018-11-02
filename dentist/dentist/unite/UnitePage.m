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

@interface UnitePage()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *mTableView;
    UIActivityIndicatorView *iv;
    
    YHPopMenuView *popView;
    
    NSArray *datas;
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
    
}
@end

@implementation UnitePage
    

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
   
}

-(void)setupNavigation{
    UINavigationItem *item = [self navigationItem];
    item.title = @"Unite";
    
    
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

- (void)enterTeamCard:(UIButton *)btn
{
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UniteDetailViewController *newVC = [[UniteDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

- (void)enterUniteDownloading:(MagazineModel*) model{
    UniteDownloadingViewController *vc = [[UniteDownloadingViewController alloc]init];
    vc.magazineModel = model;
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
        [mTableView reloadData];
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
    popView.iconNameArray = @[@"arrow",@"arrow",@"arrow",];
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
                MagazineModel *model = [[MagazineModel alloc]init];
                model.publishDate = @"111";
                [self enterUniteDownloading:model];
            }else if(row == 1){
                
            }else if(row == 2){
                
            }
        }
    }];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 580;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UnitePageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UnitePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.magazineModel = datas[indexPath.row];
    cell.optonBtnOnClickListener = ^(UnitePageDownloadStatus status,MagazineModel *model){
        switch (status) {
            case UPageDownloaded:
                //to detail page
                [self enterTeamCard:nil];
                break;
            case UPageNoDownload:
                //start download
                [self startUniteDownload];
            case UPageDownloading:{
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
}
@end
