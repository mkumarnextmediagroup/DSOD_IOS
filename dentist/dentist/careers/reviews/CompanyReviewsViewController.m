//
//  CompanyReviewsViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyReviewsViewController.h"
#import "Common.h"
#import "Proto.h"
#import "CareerAddReviewViewController.h"
#import "XHStarRateView.h"
#import "CompanyReviewsCell.h"
#import "CompanyReviewModel.h"
#import "CompanyReviewsDetailViewController.h"
#import "SHESelectTable.h"

@interface CompanyReviewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) JobDSOModel *jobDSOModel;
@property (nonatomic,strong) NSArray<CompanyReviewModel*> *reviewArray;

@end

@implementation CompanyReviewsViewController{
    int edge;
    UITableView *tableView;
    UIActivityIndicatorView *iv;
    
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
    
    
    UIView *sectionHeaderView;
    UILabel *sortValueLabel;
    UILabel *filterValueLabel;
    
    __block int sortSelectIndex;
    __block int sortSelectValue;
    __block int filterSelectIndex;
    __block int filterSelectValue;
}


+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel{
    CompanyReviewsViewController *companyReviewsVc = [CompanyReviewsViewController new];
    companyReviewsVc.jobDSOModel = jobDSOModel;
    [vc pushPage:companyReviewsVc];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addNavBar];
    
    [self buildViews];
    
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"REVIEWS";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    
    iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    iv.tag = 998;
    iv.backgroundColor = [UIColor clearColor];
    iv.center = item.rightBarButtonItem.customView.center;
    UIBarButtonItem *ivItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    
    UIButton *writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [writeBtn addTarget:self action:@selector(writeReview) forControlEvents:UIControlEventTouchUpInside];
    [writeBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [writeBtn sizeToFit];
    UIBarButtonItem *menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:writeBtn];
    
    
    self.navigationItem.rightBarButtonItems  = @[menuBtnItem,fixedSpaceBarButtonItem,ivItem];
    
}

-(void)buildViews{
    edge = 18;
    
    tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableHeaderView = [self buildHeader];
    [[[[tableView.tableHeaderView.layoutUpdate topParent:0]leftParent:0]widthEq:SCREENWIDTH] install];
    [tableView layoutIfNeeded];
     [tableView registerClass:CompanyReviewsCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewsCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] bottomParent:0] install];
    
    
    [self setupRefresh];
}


-(UIView*)buildHeader{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    UILabel *nameLabel = headerView.addLabel;
    nameLabel.text = self.jobDSOModel.name;
    nameLabel.font = [Fonts regular:15];
    nameLabel.textColor = rgbHex(0x4A4A4A);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [[[[[nameLabel.layoutMaker centerXParent:0] topParent:10] leftParent:edge]rightParent:-edge] install];

    
    UIView *starRateViewBg = headerView.addView;
    [[[[starRateViewBg.layoutMaker below:nameLabel offset:5]centerXParent:0]sizeEq:75 h:14] install];
    
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 75, 14)];
    starRateView.isAnimation = YES;
    starRateView.userInteractionEnabled = NO;
    starRateView.rateStyle = HalfStar;
    starRateView.currentScore = self.jobDSOModel.rating;
    [starRateViewBg addSubview:starRateView];
    

    UILabel *reviewNumLabel = headerView.addLabel;
    reviewNumLabel.text = [NSString stringWithFormat:@"%ld Reviews" ,self.jobDSOModel.reviewNum];
    reviewNumLabel.font = [Fonts regular:12];
    reviewNumLabel.textColor = rgbHex(0x879AA8);
    [[[[reviewNumLabel.layoutMaker centerXParent:0] below:starRateViewBg offset:5]bottomParent:-10]  install];
    
    return headerView;
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
    if(isRefreshing){
        return;
    }
    
    [self showTopIndicator];
    [Proto findCommentByCompanyId:self.jobDSOModel.id sort:sortSelectValue star:filterSelectValue skip:isMore?self.reviewArray.count:0 limit:10 completed:^(NSArray<CompanyReviewModel *> *reviewArray) {
        [self reloadData:[reviewArray copy]  isMore:isMore];
        [self hideTopIndicator];
    }];
}

-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(newDatas!=nil){
        if(isMore){
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:self.reviewArray];
            [mutableArray addObjectsFromArray:newDatas];
            self.reviewArray = [mutableArray copy];
        }else{
            self.reviewArray = newDatas;
        }
        [tableView reloadData];
    }
}


-(void)writeReview{
    [CareerAddReviewViewController openBy:self dsoId:self.jobDSOModel.id successCallbak:^{
        //todo reload data
    }];
}




-(void)sortOnClick:(UIView*)view{
    NSArray *sortArray=@[@"All Reviews",
                         @"Recommends",
                         @"Approved of CEO",
                         @"Current Employee",
                         @"Former Employee",
                         @"Date (Newest first)",
                         @"Date (Oldest first)",
                         ];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[view convertRect: view.bounds toView:window];
    CGRect tableFrame = CGRectMake(0, rect.origin.y+view.frame.size.height, SCREENWIDTH/2, sortArray.count * 35 );
    
    SHESelectTable *sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) withDataArray:sortArray];

    WeakSelf
    sTable.returnBlock=^(NSInteger index, NSString *itemText){
        StrongSelf
        strongSelf->sortSelectIndex = (int)index;
        strongSelf->sortSelectValue = (int)index;
        strongSelf->sortValueLabel.text = itemText;
        [weakSelf getDatas:NO];
    };
    [sTable setSelectIndex:sortSelectIndex];
    [sTable showWithFrame:tableFrame];
}

-(void)filterOnClick:(UIView*)view{
    
    NSArray *sortArray=@[@"All Reviews",
                         @"5 Stars",
                         @"4 Stars",
                         @"3 Stars",
                         @"2 Stars",
                         @"1 Stars",
                         ];
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[view convertRect: view.bounds toView:window];
    CGRect tableFrame = CGRectMake(SCREENWIDTH/2, rect.origin.y+view.frame.size.height, SCREENWIDTH/2, sortArray.count * 35 );
    
    SHESelectTable *sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) withDataArray:sortArray];
    
    WeakSelf
    sTable.returnBlock=^(NSInteger index, NSString *itemText){
        StrongSelf
        NSArray<NSString*> *filterIndex = @[@"0",@"5",@"4",@"3",@"2",@"1"];
        strongSelf->filterSelectIndex = (int)index;
        strongSelf->filterSelectValue = filterIndex[(int)index].intValue;
        strongSelf->filterValueLabel.text = itemText;
        [weakSelf getDatas:NO];
    };
    [sTable setSelectIndex:filterSelectIndex];
    [sTable showWithFrame:tableFrame];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(!sectionHeaderView){
        sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        sectionHeaderView.backgroundColor = UIColor.whiteColor;
        
        
        
        UIView *sortView = sectionHeaderView.addView;
        [[[[[sortView.layoutMaker leftParent:0]topParent:0]bottomParent:0]widthEq:SCREENWIDTH/2] install];
        [sortView onClickView:self action:@selector(sortOnClick:)];
        
        UIImageView *sortIv = sortView.addImageView;
        sortIv.imageName = @"icon_sort";
        [[[[sortIv.layoutMaker leftParent:35]topParent:5]sizeEq:30 h:30]install];
        
        UILabel *sortLabel = sortView.addLabel;
        sortLabel.font = [Fonts regular:11];
        sortLabel.textColor = rgbHex(0x4A4A4A);
        sortLabel.text=@"SORT BY";
        [[[sortLabel.layoutMaker topParent:9]toRightOf:sortIv offset:3]install];
       
        
        sortValueLabel = sortView.addLabel;
        sortValueLabel.font = [Fonts regular:9];
        sortValueLabel.textColor = rgbHex(0x879AA8);
        sortValueLabel.text=@"All Reviews";
        [[[sortValueLabel.layoutMaker below:sortLabel offset:0]toRightOf:sortIv offset:3] install];
        
        
        
        UIView *filterView = sectionHeaderView.addView;
        [[[[[filterView.layoutMaker rightParent:0]topParent:0]bottomParent:0]widthEq:SCREENWIDTH/2] install];
        [filterView onClickView:self action:@selector(filterOnClick:)];
        
        UIImageView *filterIv = filterView.addImageView;
        filterIv.imageName = @"icon_filter";
        [[[[filterIv.layoutMaker leftParent:35]topParent:5]sizeEq:30 h:30]install];
        
        
        UILabel *filterLabel = filterView.addLabel;
        filterLabel.font = [Fonts regular:11];
        filterLabel.textColor = rgbHex(0x4A4A4A);
        filterLabel.text=@"REFINE";
        [[[filterLabel.layoutMaker topParent:9]toRightOf:filterIv offset:3]install];
        
        
        filterValueLabel = filterView.addLabel;
        filterValueLabel.font = [Fonts regular:9];
        filterValueLabel.textColor = rgbHex(0x879AA8);
        filterValueLabel.text=@"All Stars";
        [[[filterValueLabel.layoutMaker below:filterLabel offset:0]toRightOf:filterIv offset:3] install];
        
        
        
        UILabel *topLineLabel = sectionHeaderView.lineLabel;
        [[[[[topLineLabel.layoutMaker leftParent:0]topParent:0]rightParent:0]heightEq:1]install];
        
        UILabel *bottomLineLabel = sectionHeaderView.lineLabel;
        [[[[[bottomLineLabel.layoutMaker leftParent:0]bottomParent:0]rightParent:0]heightEq:1]install];
        
        UILabel *centerLineLabel = sectionHeaderView.lineLabel;
        [[[[[centerLineLabel.layoutMaker centerXParent:0]widthEq:1]topParent:5]bottomParent:-5] install];

    }
    return sectionHeaderView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reviewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyReviewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CompanyReviewsCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeakSelf
    [cell setData:self.reviewArray[indexPath.row] jobDSOModel:self.jobDSOModel seeMoreListener:^(JobDSOModel*jobDSOModel,CompanyReviewModel*reviewModel){
        [CompanyReviewsDetailViewController openBy:weakSelf jobDSOModel:jobDSOModel companyReviewModel:reviewModel];
    }];
    return cell;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
}



@end
