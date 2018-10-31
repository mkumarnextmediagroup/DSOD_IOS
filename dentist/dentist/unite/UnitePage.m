//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UnitePage.h"
#import "Common.h"
#import "UnitePageCell.h"
#import "Proto.h"

@interface UnitePage()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *mTableView;
    UIActivityIndicatorView *iv;
    
    NSArray *datas;
    UIRefreshControl *refreshControl;
    
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
    [menuBtn addTarget:self action:@selector(enterTeamCard:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setImage:[UIImage imageNamed:@"Animation"] forState:UIControlStateNormal];
    [menuBtn sizeToFit];
    UIBarButtonItem *menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
    self.navigationItem.rightBarButtonItems  = @[menuBtnItem,fixedSpaceBarButtonItem,ivItem];
    
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
}

- (void)hideTopIndicator {
    iv.hidden = YES;
    [iv stopAnimating];
}


-(void)firstRefresh{
     [self getDatas:NO];
     [refreshControl endRefreshing];
}


-(void)getDatas:(BOOL)isMore{
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


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 600;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UnitePageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UnitePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.magazineModel = datas[indexPath.row];
    return cell;
}


@end
