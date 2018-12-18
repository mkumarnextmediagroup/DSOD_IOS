//
//  CompanyDetailViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyDetailViewController.h"
#import "Common.h"
#import "UIView+Toast.h"
#import "CompanyModel.h"
#import "JobModel.h"
#import "Proto.h"
#import "DentistTabView.h"
#import "UIView+Toast.h"
#import "CompanyJobsModel.h"
#import "BannerScrollView.h"
#import "CareerSearchViewController.h"

#import "CompanyDetailDescriptionViewController.h"
#import "CompanyDetailJobsViewController.h"
#import "CompanyDetailReviewsViewController.h"
#import "AllowMultiGestureTableView.h"
#import "JobDetailViewController.h"
#import "JobDSOModel.h"
#import "MapViewController.h"

@interface CompanyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate,CompanyDetailJobsViewDelegate>

@property (nonatomic,strong) UIView* tableContentView;
@property (nonatomic) BOOL isCanScroll;
@property (nonatomic,strong) CompanyDetailDescriptionViewController *descriptionVC;
@property (nonatomic,strong) CompanyDetailJobsViewController *jobsVC;
@property (nonatomic,strong) CompanyDetailReviewsViewController *reviewsVC;



@end

@implementation CompanyDetailViewController{
    
    UIView *contentView;
    UITableView *tableView;
    
    BannerScrollView *bannerView;
    UIImageView *singleImageView;
    UIWebView *vedioWebView;
    
    UIView *sectionHeaderView;
    
    int edge;
    int currTabIndex;//0:description 1:company 2:reviews
    
    JobDSOModel *companyModel;
    
    
    
}


+(void)openBy:(UIViewController*)vc companyId:(NSString*)companyId{
    if(companyId){
        CompanyDetailViewController *detailPageVc = [CompanyDetailViewController new];
        detailPageVc.companyId = companyId;
        [vc pushPage:detailPageVc];
    }else{
        [vc.view makeToast:@"companyId is null"];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self addNavBar];
    
    [self setupTableContentVC];
    
    
    [self showLoading];
    [Proto findCompanyById:self.companyId completed:^(JobDSOModel * _Nullable companyModel) {
        [self hideLoading];
        if(companyModel){
            self->companyModel = companyModel;
            [self buildView];
        }
    }];
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"DSO COMPANY";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}



-(void)buildView{
    contentView  = self.view.addView;
    [[[[[contentView.layoutMaker leftParent:0]rightParent:0] topParent:NAVHEIGHT]bottomParent:0] install];
    contentView.backgroundColor = UIColor.whiteColor;
    
    tableView = [AllowMultiGestureTableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [contentView addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    tableView.tableHeaderView =[self buildHeader];
    [[[tableView.tableHeaderView.layoutUpdate topParent:0]leftParent:0] install];
   
    
}


-(UIView*)buildHeader{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CGFLOAT_MIN)];
    
    UIView *mediaView = headerView.addView;
    [[[[[mediaView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH h:SCREENWIDTH/2]install];
    
    
    bannerView = [BannerScrollView new];
    [mediaView addSubview:bannerView];
    [[[[[bannerView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH     h:SCREENWIDTH/2]install];
    
    
    singleImageView= mediaView.addImageView;
    [singleImageView scaleFillAspect];
    singleImageView.clipsToBounds = YES;
    [[[[[singleImageView.layoutMaker leftParent:0]rightParent:0]topParent:    0]sizeEq:SCREENWIDTH h:SCREENWIDTH/2]install];
    
    
    vedioWebView = [UIWebView new];
    [mediaView addSubview:vedioWebView];
    vedioWebView.scrollView.scrollEnabled = NO;
    [[[[[vedioWebView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH     h:SCREENWIDTH/2]install];
    
    
    UIImageView *logoImageView = headerView.addImageView;
    [logoImageView scaleFillAspect];
    logoImageView.clipsToBounds = YES;
    [[[[logoImageView.layoutMaker leftParent:edge]below:mediaView offset:10] sizeEq:60 h:60]install];
    
    
    UILabel *companyLabel = headerView.addLabel;
    companyLabel.font = [Fonts semiBold:16];
    [[[[companyLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:-edge] below:mediaView offset:10]install] ;
    
    
    UIButton *addressBtn = headerView.addButton;
    addressBtn.titleLabel.font = [Fonts regular:12];
    [addressBtn setTitleColor:Colors.textMain forState:UIControlStateNormal];
    [addressBtn onClick:self action:@selector(showLocation)];
    addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 50);
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"career_location_bg_small"] forState:UIControlStateNormal];
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"career_location_bg_samll"] forState:UIControlStateHighlighted];
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addressBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addressBtn.titleLabel.numberOfLines = 3;
    [[[[[addressBtn.layoutMaker below:companyLabel offset:10] toRightOf:logoImageView offset:10]rightParent:-edge] heightEq:42]install];
    
    
    UIView *lastView = headerView.addView;
    [[[[[lastView.layoutMaker below:addressBtn offset:0]leftParent:0]rightParent:0]heightEq:10]install];
    
    vedioWebView.hidden = YES;
    bannerView.hidden = YES;
    singleImageView.hidden = YES;
    
    NSArray *mediaURL = companyModel.mediaURL;
    NSArray *media = companyModel.media;
    if(companyModel.media_type == 1 && mediaURL && mediaURL.count > 0 ){
        if(mediaURL.count>1){
            bannerView.hidden = NO;
            [bannerView addWithImageUrls:mediaURL autoTimerInterval:3 clickBlock:^(NSInteger index) {

            }];
        }else{
            singleImageView.hidden = NO;
            [singleImageView loadUrl:mediaURL[0] placeholderImage:nil];
        }
    }else if(companyModel.media_type == 2 && media && media.count > 0) {
        vedioWebView.hidden = NO;
        [self showVideo:media[0]];
    }
    
    
    [logoImageView loadUrl:companyModel.logoURL placeholderImage:nil];
    companyLabel.text = companyModel.name;
    [addressBtn setTitle:companyModel.address1 forState:UIControlStateNormal];
    
    
    [headerView.layoutUpdate.bottom.equalTo(lastView.mas_bottom) install];
    [headerView layoutIfNeeded];
    
    
    return headerView;
}


-(void)showVideo:(NSString*)videoHtmlString{
    if(videoHtmlString){
        NSRange iframeStart = [videoHtmlString rangeOfString:@"<iframe"];
        NSRange iframeEnd = [videoHtmlString rangeOfString:@"</iframe>"];
        
        if(iframeStart.location != NSNotFound && iframeEnd.location != NSNotFound){
            
            NSString *htmlString = videoHtmlString;
            htmlString = [htmlString substringWithRange:NSMakeRange(iframeStart.location,iframeEnd.location+iframeEnd.length - iframeStart.location)];
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"src=\"//" withString:@"src=\"https://"];
            htmlString = [NSString stringWithFormat:@"%@%@%@%@%@",
                          @"<style type=\"text/css\">",
                          @"body{padding:0px;margin:0px;background:#fff;font-family}",
                          @"iframe{border: 0 none;}",
                          @"</style>",
                          htmlString
                          ];
            [vedioWebView loadHTMLString:htmlString baseURL:nil];
        }
    }
}





- (void)searchClick{
    CareerSearchViewController *searchVC=[CareerSearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)showLocation{
    if(companyModel && companyModel.position && companyModel.position.count==2){
        double longitude = ((NSString*)companyModel.position[0]).doubleValue;
        double latitude = ((NSString*)companyModel.position[1]).doubleValue;
        [MapViewController openBy:self latitude:latitude longitude:longitude title:companyModel.name subTitle:companyModel.address1];
    }else{
        [self.view makeToast:@"location error"];
    }
}


-(void)setupTableContentVC{
    self.isCanScroll = YES;
    self.descriptionVC = [CompanyDetailDescriptionViewController new];
    self.jobsVC = [CompanyDetailJobsViewController new];
    self.reviewsVC = [CompanyDetailReviewsViewController new];

    self.jobsVC.delegate=self;
    
    WeakSelf;
    self.descriptionVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.jobsVC.isCanScroll = NO;
        [weakSelf.jobsVC contentOffsetToPointZero];
        weakSelf.reviewsVC.isCanScroll = NO;
        [weakSelf.reviewsVC contentOffsetToPointZero];
        
    };
    self.jobsVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.descriptionVC.isCanScroll = NO;
        [weakSelf.descriptionVC contentOffsetToPointZero];
        weakSelf.reviewsVC.isCanScroll = NO;
        [weakSelf.reviewsVC contentOffsetToPointZero];
    };
    self.reviewsVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.descriptionVC.isCanScroll = NO;
        [weakSelf.descriptionVC contentOffsetToPointZero];
        weakSelf.jobsVC.isCanScroll = NO;
        [weakSelf.jobsVC contentOffsetToPointZero];
    };
}


-(UIView*)tableContentView{
    if(!_tableContentView){
        _tableContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVHEIGHT - 50)];
        
        
        
        self.descriptionVC.view.frame = _tableContentView.frame;
        [self.descriptionVC setData:companyModel.dsoDescription];
        [_tableContentView addSubview:self.descriptionVC.view];
        
        
        self.jobsVC.view.frame = _tableContentView.frame;
        self.jobsVC.companyId = companyModel.id;
        [_tableContentView addSubview:self.jobsVC.view];
        
        
        self.reviewsVC.view.frame = _tableContentView.frame;
        self.reviewsVC.companyId = companyModel.id;
        self.reviewsVC.vc = self;
        [_tableContentView addSubview:self.reviewsVC.view];
        
        [self didDentistSelectItemAtIndex:currTabIndex];
    }
    return _tableContentView;
}

#pragma mark DentistTabViewDelegate
- (void)didDentistSelectItemAtIndex:(NSInteger)index{
    currTabIndex = (int)index;
    switch (currTabIndex) {
        case 0:
            self.descriptionVC.view.hidden = NO;
            self.jobsVC.view.hidden = YES;
            self.reviewsVC.view.hidden = YES;
            break;
        case 1:
            self.descriptionVC.view.hidden = YES;
            self.jobsVC.view.hidden = NO;
            self.reviewsVC.view.hidden = YES;
            break;
        case 2:
            self.descriptionVC.view.hidden = YES;
            self.jobsVC.view.hidden = YES;
            self.reviewsVC.view.hidden = NO;
            break;
            
        default:
            break;
    }}



#pragma mark UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(!sectionHeaderView){
        sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        
        
        DentistTabView *tabView = [DentistTabView new];
        tabView.isScrollEnable=NO;
        tabView.itemCount=3;
        tabView.delegate=self;
        [sectionHeaderView addSubview:tabView];
        [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:50] install];
        tabView.titleArr=[NSMutableArray arrayWithArray:@[@"DESCRIPTION",@"JOBS",@"REVIEWS"]];

    }
    return sectionHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREENHEIGHT - NAVHEIGHT - 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    [cell.contentView addSubview:self.tableContentView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollY = [tableView rectForSection:0].origin.y;
    if (tableView.contentOffset.y >= scrollY) {
        if (self.isCanScroll == YES) {
            self.isCanScroll = NO;
            
            self.descriptionVC.isCanScroll = YES;
            [self.descriptionVC contentOffsetToPointZero];
            self.jobsVC.isCanScroll = YES;
            [self.jobsVC contentOffsetToPointZero];
            self.reviewsVC.isCanScroll = YES;
            [self.reviewsVC contentOffsetToPointZero];
        }
        
        tableView.contentOffset = CGPointMake(0, scrollY);
    }else{
        if (self.isCanScroll == NO) {
            tableView.contentOffset = CGPointMake(0, scrollY);
        }
    }
}

#pragma mark CompanyDetailJobsViewDelegate
-(void)CompanyDetailJobsViewDidSelectAction:(NSString *)jobId
{
    [JobDetailViewController presentBy:self.parentViewController jobId:jobId closeBack:^{
        foreTask(^{
            [self.jobsVC reloadData];
        });
        
    }];
}



@end
