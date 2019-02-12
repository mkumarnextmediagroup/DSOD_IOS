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
@property (nonatomic,strong) NSArray<CompanyReviewModel*> *reviewArray;

@property (nonatomic,copy) void(^onReviewNumChanged)(NSInteger reviewNum);

@end

@implementation CompanyReviewsViewController{
    int edge;
    UITableView *tableView;
    UIActivityIndicatorView *iv;
    
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
    
    UILabel *reviewNumLabel;
    
    
    UIView *sectionHeaderView;
    UILabel *sortValueLabel;
    UIImageView *sortIconIv;
    UILabel *filterValueLabel;
    
    __block int sortSelectIndex;
    __block int sortSelectValue;
    __block int filterSelectIndex;
    __block int filterSelectValue;
    
    __block BOOL dateSortDown;
    __block BOOL ratingSortDown;
    
    __block int totalFound;//最新数据总条数
}


/**
 open reviews list of dso page

 @param vc UIViewController
 @param jobDSOModel jobDSOModel instance
 */
+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel{
    [CompanyReviewsViewController openBy:vc jobDSOModel:jobDSOModel onReviewNumChanged:^(NSInteger reviewNum) {
        
    }];
}

/**
 open reviews list of dso page

 @param vc UIViewController
 @param jobDSOModel jobDSOModel instance
 @param onReviewNumChanged Comment numbers change callback event
 */
+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel onReviewNumChanged:(void(^)(NSInteger reviewNum))onReviewNumChanged{
    CompanyReviewsViewController *companyReviewsVc = [CompanyReviewsViewController new];
    companyReviewsVc.jobDSOModel = jobDSOModel;
    companyReviewsVc.onReviewNumChanged = onReviewNumChanged;
    [vc pushPage:companyReviewsVc];
}


/**
 view did load
 add navigation bar
 build views
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    edge = 18;
    dateSortDown = YES;
    ratingSortDown = YES;
    
    [self addNavBar];
    
    [self buildViews];
    
}

/**
 add navigation bar
 */
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


/**
 colse page
 If the number of comments changes, callback onReviewNumChanged function
 */
- (void)dismiss {
    if(totalFound > self.jobDSOModel.reviewNum && self.onReviewNumChanged){
        self.onReviewNumChanged(totalFound);
    }
    [super dismiss];
}

/**
 build views
 */
-(void)buildViews{
    edge = 18;
    
    tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 1000;
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

/**
 build header
 dso name、star、reivews numbers
 */
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
    

    reviewNumLabel = headerView.addLabel;
    reviewNumLabel.text = [NSString stringWithFormat:@"%ld Reviews" ,self.jobDSOModel.reviewNum];
    reviewNumLabel.font = [Fonts regular:12];
    reviewNumLabel.textColor = rgbHex(0x879AA8);
    [[[[reviewNumLabel.layoutMaker centerXParent:0] below:starRateViewBg offset:5]bottomParent:-10]  install];
    
    return headerView;
}

/**
 setup tableview refresh event
 */
-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    [self firstRefresh];
}


/**
 show loading
 */
- (void)showTopIndicator {
    iv.hidden = NO;
    [iv startAnimating];
    isRefreshing = YES;
}

/**
 stop loading
 */
- (void)hideTopIndicator {
    iv.hidden = YES;
    [iv stopAnimating];
    isRefreshing = NO;
}

/**
 first load data
 */
-(void)firstRefresh{
    [self getDatas:NO];
    [refreshControl endRefreshing];
}

/**
 get data from server
 
 @param isMore whether loading more
 */
-(void)getDatas:(BOOL)isMore{
    if(isRefreshing){
        return;
    }
    
    [self showTopIndicator];
    [Proto findCommentByCompanyId:self.jobDSOModel.id sort:sortSelectValue star:filterSelectValue skip:isMore?self.reviewArray.count:0 limit:10 completed:^(NSArray<CompanyReviewModel *> *reviewArray,NSInteger totalFound) {
        
        if(self->totalFound<totalFound){
            self->totalFound = (int)totalFound;
        }
        self->reviewNumLabel.text = [NSString stringWithFormat:@"%d Reviews" ,self->totalFound];
        [self reloadData:[reviewArray copy]  isMore:isMore];
        [self hideTopIndicator];
    }];
}

/**
 table view reload data
 Update data source
 Refresh form
 
 @param newDatas new data
 @param isMore whether loading more
 */
-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(newDatas!=nil){
        if(isMore){
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:self.reviewArray];
            [mutableArray addObjectsFromArray:newDatas];
            self.reviewArray = [mutableArray copy];
        }else{
            self.reviewArray = newDatas;
        }
        if(!isMore || newDatas.count > 0){
            [tableView reloadData];
        }
    }
}


/**
 write review button click event
 jump to write review page
 */
-(void)writeReview{
    WeakSelf
    [CareerAddReviewViewController openBy:self dsoId:self.jobDSOModel.id successCallbak:^{
        StrongSelf
         
        [strongSelf resetSortAndFilter];
        [strongSelf getDatas:NO];
    }];
}


/**
 重置排序条件和过滤条件
 Reset sorting criteria and filters
 */
-(void)resetSortAndFilter{
    self->sortSelectIndex = 0;
    self->sortSelectValue = 0;
    self->sortValueLabel.text = @"Date";
    self->sortIconIv.imageName = @"icon_d_sel";
    self->dateSortDown = YES;
    self->ratingSortDown = YES;
    
    self->filterSelectIndex = 0;
    self->filterSelectValue = 0;
    self->filterValueLabel.text = @"All Reviews";
}

/**
 排序条件点击事件
 初始化数据，弹出菜单
 Sorting condition click event
 Initialize data, popup menu
 
 @param view Responsive view
 */
-(void)sortOnClick:(UIView*)view{
    NSString *dataIcon = @"icon_d_sel";
    NSString *ratingIcon = @"icon_d_sel";
    
    //初始化按钮图标
    //Initialize menu icon
    if(sortSelectIndex==0){
        dataIcon = dateSortDown ?  @"icon_d_sel" :  @"icon_u_sel" ;
        ratingIcon = ratingSortDown ?  @"icon_d_unsel" :  @"icon_u_unsel" ;
    }else{
        dataIcon = dateSortDown ?  @"icon_d_unsel" :  @"icon_u_unsel" ;
        ratingIcon = ratingSortDown ?  @"icon_d_sel" :  @"icon_u_sel" ;
    }
    
    
    NSArray *sortArray=@[
                         @{@"text":@"Date",@"icon":dataIcon},
                         @{@"text":@"Rating",@"icon":ratingIcon}
                         ];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[view convertRect: view.bounds toView:window];
    CGRect tableFrame = CGRectMake(0, rect.origin.y+view.frame.size.height, SCREENWIDTH/2, sortArray.count * 35 );
    
    SHESelectTable *sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) withDataArray:sortArray];

    WeakSelf
    sTable.returnBlock=^(NSInteger index, NSString *itemText){
        StrongSelf
        if(strongSelf->sortSelectIndex == index){
            //click index same , change icon
            if(index == 0){
                strongSelf->dateSortDown = !strongSelf->dateSortDown;
            }else{
                strongSelf->ratingSortDown = !strongSelf->ratingSortDown;
            }
        }
        
        //        0:ALL
        //        1:Date(Newest first)
        //        2:Date(Oldset first)
        //        3:Rating (降序)
        //        4:Rating (升序)
        strongSelf->sortSelectIndex = (int)index;
        if(index == 0){
            strongSelf->sortIconIv.imageName = strongSelf->dateSortDown ? @"icon_d_sel" : @"icon_u_sel";
            strongSelf->sortSelectValue = strongSelf->dateSortDown?1:2;
        }else{
            strongSelf->sortIconIv.imageName = strongSelf->ratingSortDown ? @"icon_d_sel" : @"icon_u_sel";
            strongSelf->sortSelectValue = strongSelf->ratingSortDown?3:4;
        }
        
        strongSelf->sortValueLabel.text = itemText;
        [weakSelf getDatas:NO];
    };
    sTable.cellType = CellTypeCustomIcon;
    [sTable setSelectIndex:sortSelectIndex];
    [sTable showWithFrame:tableFrame];
}

/**
 过滤条件点击事件
 初始化数据，弹出菜单
 filter  click event
 Initialize data, popup menu
 
 @param view Responsive view
 */
-(void)filterOnClick:(UIView*)view{
    
    NSArray *sortArray=@[@{@"text":@"All Reviews"},
                         @{@"text":@"Current Employee"},
                         @{@"text":@"Former Employee"}
                         ];
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[view convertRect: view.bounds toView:window];
    CGRect tableFrame = CGRectMake(SCREENWIDTH/2, rect.origin.y+view.frame.size.height, SCREENWIDTH/2, sortArray.count * 35 );
    
    SHESelectTable *sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) withDataArray:sortArray];
    
    WeakSelf
    sTable.returnBlock=^(NSInteger index, NSString *itemText){
        StrongSelf
        strongSelf->filterSelectIndex = (int)index;
        strongSelf->filterSelectValue = (int)index;
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
        sortValueLabel.text=@"Date";
        [[[sortValueLabel.layoutMaker below:sortLabel offset:0]toRightOf:sortIv offset:3] install];
        
        sortIconIv = sortView.addImageView;
        sortIconIv.imageName = @"icon_d_sel";
        [sortIconIv scaleFillAspect];
        [[[[sortIconIv.layoutMaker centerYOf:sortValueLabel offset:0]toRightOf:sortIv offset:35]sizeEq:7 h:5] install];
        
        
        
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
        filterValueLabel.text=@"All Reviews";
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

/**
 Handling paged load data
 
 @param scrollView UIScrollView
 @param decelerate BOOL
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
}



@end
