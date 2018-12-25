//
//  CompanyExistsReviewsViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/16.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyExistsReviewsViewController.h"
#import "Common.h"
#import "Proto.h"
#import "CompanyExistsReviewsTableViewCell.h"
#import "AppDelegate.h"
#import "CompanyReviewsViewController.h"
#import "CareerSearchViewController.h"
#import "DSOProfileSearchPage.h"

@interface CompanyExistsReviewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CompanyExistsReviewsViewController{
    
    int edge;
    UITableView *tableView;
    UIActivityIndicatorView *iv;
    
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
    
    NSArray<JobDSOModel*> *companyModelArray;
    NSInteger totalCount;
}


+(void)openBy:(UIViewController*)vc {
    CompanyExistsReviewsViewController *companyVc = [CompanyExistsReviewsViewController new];
    [vc pushPage:companyVc];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    edge = 18;
    
    [self addNavBar];
    
    [self buildView];
    
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"REVIEWS";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(backToFirst)];
    
    
    iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    iv.tag = 998;
    iv.backgroundColor = [UIColor clearColor];
    iv.center = item.rightBarButtonItem.customView.center;
    UIBarButtonItem *ivItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"searchWhite"] forState:UIControlStateNormal];
    [searchBtn sizeToFit];
    UIBarButtonItem *menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    
    self.navigationItem.rightBarButtonItems  = @[menuBtnItem,fixedSpaceBarButtonItem,ivItem];
    
}

- (void)backToFirst
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabvc=(UITabBarController *)appdelegate.careersPage;
    [tabvc setSelectedIndex:0];
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

- (void)searchClick
{
    NSLog(@"search btn click");
    
    DSOProfileSearchPage *searchVC=[DSOProfileSearchPage new];
    searchVC.isDSOProfile = NO;
    [self.navigationController pushViewController:searchVC animated:NO];
    
}

-(void)buildView{
    edge = 18;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:CompanyExistsReviewsTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyExistsReviewsTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    
    [self setupRefresh];
}



-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
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
    if(isRefreshing || (isMore && companyModelArray.count == totalCount)){
        return;
    }
    
    [self showTopIndicator];
    [Proto findCompanyExistsReviewsList:isMore?self->companyModelArray.count:0 searchValue:nil completed:^(NSArray<JobDSOModel *> *array, NSInteger totalCount) {
            self->totalCount = totalCount;
            [self reloadData:[array copy]  isMore:isMore];
            [self hideTopIndicator];
    }];
}

-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(newDatas!=nil && newDatas.count >0){
        if(isMore){
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:companyModelArray];
            [mutableArray addObjectsFromArray:newDatas];
            companyModelArray = [mutableArray copy];
        }else{
            companyModelArray = newDatas;
        }
        [tableView reloadData];
    }
}



#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return companyModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyExistsReviewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CompanyExistsReviewsTableViewCell.class) forIndexPath:indexPath];
    
    [cell setData:companyModelArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [CompanyReviewsViewController openBy:self jobDSOModel:companyModelArray[indexPath.row]];
}

@end
