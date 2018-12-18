//
//  JobDetailViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JobDetailViewController.h"
#import "Common.h"
#import "Proto.h"
#import "DsoToast.h"
#import "UIView+Toast.h"
#import "BannerScrollVIew.h"
#import "DentistTabView.h"
#import "AllowMultiGestureTableView.h"
#import "JobDetailDescriptionViewController.h"
#import "JobDetailCompanyViewController.h"
#import "JobDetailReviewsViewController.h"
#import "JobModel.h"
#import "DentistDataBaseManager.h"
#import "MapViewController.h"
#import "CareerAddReviewViewController.h"
#import <Social/Social.h>

@interface JobDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate>
@property (nonatomic,strong) NSString *jobId;
@property (copy, nonatomic) CareerJobDetailCloseCallback closeBack;


@property (nonatomic,strong) UIView* tableContentView;
@property (nonatomic) BOOL isCanScroll;
@property (nonatomic,strong) JobDetailDescriptionViewController *descriptionVC;
@property (nonatomic,strong) JobDetailCompanyViewController *companyVC;
@property (nonatomic,strong) JobDetailReviewsViewController *reviewsVC;

@end

@implementation JobDetailViewController{
    UIView *contentView;
    UIView *naviBarView;
    UITableView *tableView;

    BannerScrollView *bannerView;
    UIImageView *singleImageView;
    UIWebView *vedioWebView;
    UIButton *attentionButton;
    UIView *sectionHeaderView;

    int edge;
    int navBarOffset;
    int navBarHeight;
    int currTabIndex;//0:description 1:company 2:reviews

    JobModel *jobModel;
   
}



+(void)presentBy:(UIViewController*)vc jobId:(NSString*)jobId{
    [self presentBy:vc jobId:jobId closeBack:nil];
}
+(void)presentBy:(UIViewController*)vc jobId:(NSString*)jobId closeBack:(CareerJobDetailCloseCallback)closeBack
{
    [[DentistDataBaseManager shareManager] updateCareersJobs:jobId completed:^(BOOL result) {
    }];
    UIViewController *viewController;
    if (vc) {
        viewController=vc;
    }else{
        viewController= [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    
    JobDetailViewController *jobDetailVc = [JobDetailViewController new];
    jobDetailVc.jobId =jobId;
    jobDetailVc.closeBack = closeBack;
    jobDetailVc.modalPresentationStyle = UIModalPresentationCustom;
    jobDetailVc.view.backgroundColor = UIColor.clearColor;
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:jobDetailVc];
    nvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    nvc.view.backgroundColor = [UIColor clearColor];
    
    [viewController presentViewController:nvc animated:YES completion:^{
        jobDetailVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    edge = 18;
    navBarOffset = 50;
    navBarHeight = 44;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    contentView  = self.view.addView;
    [[[[[contentView.layoutMaker leftParent:0]rightParent:0] topParent:navBarOffset]bottomParent:0] install];
    contentView.backgroundColor = UIColor.whiteColor;
    
    [self addNavBar];
    
    [self setupTableContentVC];

    [self showLoading];

    [Proto findJobById:self.jobId completed:^(JobModel * _Nullable jobModel) {
        [self hideLoading];
        if(jobModel){
            self->jobModel = jobModel;
            [self buildView];
            if ([jobModel.isAttention isEqualToString:@"1"]) {
                [self->attentionButton setImage:[UIImage imageNamed:@"icon_attention_select"] forState:UIControlStateNormal];
            }else
            {
                [self->attentionButton setImage:[UIImage imageNamed:@"icon_attention"] forState:UIControlStateNormal];
            }
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

-(void)addNavBar{
    
    naviBarView = contentView.addView;
    naviBarView.backgroundColor = Colors.textDisabled;
    [[[naviBarView.layoutMaker sizeEq:SCREENWIDTH h:navBarHeight] topParent:0]install];
    
    UIImageView *closeView = naviBarView.addImageView;
    closeView.image = [UIImage imageNamed:@"icon_arrow_down"];
    [closeView onClickView:self action:@selector(closePage)];
    [[[closeView.layoutMaker sizeEq:100 h:40]centerParent]install];
    
    UIImageView *shareView = naviBarView.addImageView;
    shareView.image = [UIImage imageNamed:@"icon_share_white"];
    [shareView onClickView:self action:@selector(share)];
    [[[[shareView.layoutMaker sizeEq:44 h:44] centerYParent:0] rightParent:-5] install];
    
    
    attentionButton = naviBarView.addButton; //bgView.addButton;
    [attentionButton addTarget:self action:@selector(attention) forControlEvents:UIControlEventTouchUpInside];
    [[[[attentionButton.layoutMaker sizeEq:44 h:44]centerYParent:0]toLeftOf:shareView offset:0] install];
    
}


-(void)buildView{
    
    tableView = [AllowMultiGestureTableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.estimatedRowHeight = 10;
//    tableView.rowHeight=UITableViewAutomaticDimension;
//    tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [contentView addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] below:naviBarView offset:0] bottomParent:0] install];
    tableView.tableHeaderView =[self buildHeader];
    [[[tableView.tableHeaderView.layoutUpdate topParent:0]leftParent:0] install];
    
    UIButton *applyNowBtn = contentView.addButton;
    applyNowBtn.tag=99;
    applyNowBtn.layer.borderWidth = 1;
    applyNowBtn.layer.borderColor = rgbHex(0xb3bfc7).CGColor;
    applyNowBtn.backgroundColor = Colors.textDisabled;
    applyNowBtn.titleLabel.font = [Fonts regular:16];
    [applyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyNowBtn setTitle:@"Apply Now" forState:UIControlStateNormal];
    [[[[[applyNowBtn.layoutMaker bottomParent:-edge]leftParent:edge]rightParent:-edge]heightEq:40]install];
    [applyNowBtn onClick:self action:@selector(applyNow)];
    
    applyNowBtn.layer.shadowOffset =  CGSizeMake(0, 0);
    applyNowBtn.layer.shadowOpacity = 1;
    applyNowBtn.layer.shadowRadius = 30;
    applyNowBtn.layer.shadowColor =  rgbHex(0xb6b6b6).CGColor;
    
    
    BOOL isApplication = [self->jobModel.isApplication boolValue];
    [self setApplyButtonEnable:!isApplication];
}

-(void)setApplyButtonEnable:(BOOL)enable
{
    UIButton *btn=(UIButton *)[contentView viewWithTag:99];
    if (enable) {
        btn.userInteractionEnabled=YES;//交互关闭
        btn.alpha=1.0;//透明度
        [btn setTitle:@"Apply Now" forState:UIControlStateNormal];
    }else{
        btn.userInteractionEnabled=NO;//交互关闭
        btn.alpha=0.4;//透明度
        [btn setTitle:@"Have Applied" forState:UIControlStateNormal];
    }
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
    
    UILabel *jobLabel = headerView.addLabel;
    jobLabel.font = [Fonts semiBold:16];
    jobLabel.textColor = Colors.textMain;
    [[[[jobLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:-edge] below:mediaView offset:10]install] ;
    
    UILabel *companyLabel = headerView.addLabel;
    companyLabel.font = [Fonts semiBold:14];
    companyLabel.textColor = Colors.textDisabled;
    [[[[companyLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:-edge] below:jobLabel offset:5]install] ;
    
    
    UILabel *salaryLabel = headerView.addLabel;
    salaryLabel.font = [Fonts semiBold:12];
    salaryLabel.textColor = Colors.textMain;
    [[[[salaryLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:-edge] below:companyLabel offset:5]install] ;
    
    
    UIButton *addressBtn = headerView.addButton;
    addressBtn.titleLabel.font = [Fonts regular:12];
    [addressBtn setTitleColor:Colors.textMain forState:UIControlStateNormal];
    [addressBtn onClick:self action:@selector(showLocation)];
    addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 50);
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"career_location_bg"] forState:UIControlStateNormal];
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"career_location_bg"] forState:UIControlStateHighlighted];
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addressBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addressBtn.titleLabel.numberOfLines = 3;
    [[[[[addressBtn.layoutMaker below:salaryLabel offset:10]leftParent:edge]rightParent:-edge] heightEq:42]install];
    
    
    
    UIView *lastView = headerView.addView;
    [[[[[lastView.layoutMaker below:addressBtn offset:0]leftParent:0]rightParent:0]heightEq:10]install];
    
    
    vedioWebView.hidden = YES;
    bannerView.hidden = YES;
    singleImageView.hidden = YES;

    NSArray *mediaURL = jobModel.dso.mediaURL;
    NSArray *media = jobModel.dso.media;
    if(jobModel.dso.media_type == 1 && mediaURL && mediaURL.count > 0 ){
        if(mediaURL.count>1){
            bannerView.hidden = NO;
            [bannerView addWithImageUrls:mediaURL autoTimerInterval:3 clickBlock:^(NSInteger index) {
                
            }];
        }else{
            singleImageView.hidden = NO;
            [singleImageView loadUrl:mediaURL[0] placeholderImage:nil];
        }
    }else if(jobModel.dso.media_type == 2 && media && media.count > 0) {
        vedioWebView.hidden = NO;
        [self showVideo:media[0]];
    }
    
    
    [logoImageView loadUrl:jobModel.dso.logoURL placeholderImage:nil];
    jobLabel.text = [NSString stringWithFormat:@"%@ - %@",jobModel.jobTitle,jobModel.location];
    companyLabel.text = jobModel.company;
    salaryLabel.text= jobModel.salaryRange;
    [addressBtn setTitle:jobModel.address1 forState:UIControlStateNormal];
    
    
    
    
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


-(void)closePage{
    if (self.closeBack) {
        self.closeBack();
    }
    self.view.backgroundColor = UIColor.clearColor;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showLocation{
//    39.915352,116.397105
    if(jobModel && jobModel.position && jobModel.position.coordinates && jobModel.position.coordinates.count==2){
        double longitude = ((NSString*)jobModel.position.coordinates[0]).doubleValue;
        double latitude = ((NSString*)jobModel.position.coordinates[1]).doubleValue;
        [MapViewController openBy:self latitude:latitude longitude:longitude title:jobModel.dso.name subTitle:jobModel.dso.address1];
    }else{
         [self.view makeToast:@"location error"];
    }

}

-(void)attention{
    
    if ([jobModel.isAttention isEqualToString:@"1"]) {
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"UNFollowing from Job……" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionCenter completion:nil];
        [Proto deleteJobBookmark:jobModel.id completed:^(HttpResult *result) {
            NSLog(@"result=%@",@(result.code));
            if (result.code == 0) {
                foreTask(^() {
                    [self.navigationController.view hideToast];
                    [self->attentionButton setImage:[UIImage imageNamed:@"icon_attention"] forState:UIControlStateNormal];
                    self->jobModel.isAttention = @"0";
                });
            }
        }];

    }else
    {
        UIView *dsontoastview1=[DsoToast toastViewForMessage:@"Following to Job…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview1 duration:30.0 position:CSToastPositionCenter completion:nil];
        [Proto addJobBookmark:self.jobId completed:^(HttpResult *result) {
            NSLog(@"result=%@",@(result.code));
            if (result.code == 0) {
                foreTask(^() {
                    [self.navigationController.view hideToast];
                    [self->attentionButton setImage:[UIImage imageNamed:@"icon_attention_select"] forState:UIControlStateNormal];
                    self->jobModel.isAttention = @"1";
                });
            }
        }];
        
    }

    
}

-(void)share{
//    [self.view makeToast:@"share"];
//    [CareerAddReviewViewController openBy:self dsoId:jobModel.dsoId];    
    
    NSLog(@"Share click");
    if (jobModel) {
        NSString *urlstr=@"";
        NSString *title=[NSString stringWithFormat:@"%@",jobModel.jobTitle];
        //        NSInteger type = jobModel.companyType;
        //        if(type == 1){
        //            //pic
        //            NSDictionary *codeDic = _articleInfo.featuredMedia[@"code"];
        //            urlstr = codeDic[@"thumbnailUrl"];
        //        }else{
        //            urlstr = _articleInfo.featuredMedia[@"code"];
        //        }
        NSString *someid = _jobId;
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

-(void)applyNow{
    //    [self.view makeToast:@"applyNow"];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *dsontoastview=[DsoToast toastViewForMessage:@"Applying to Job…" ishowActivity:YES];
    [window showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
    [Proto addJobApplication:_jobId completed:^(HttpResult *result) {
        NSLog(@"result=%@",@(result.code));
        foreTask(^() {
            [window hideToast];
            if (result.OK) {
                //
                [self setApplyButtonEnable:NO];
            }else{
                NSString *message=result.msg;
                if([NSString isBlankString:message]){
                    message=@"Failed";
                }
                
                [window makeToast:message
                         duration:1.0
                         position:CSToastPositionBottom];
            }
        });
    }];
}




-(void)setupTableContentVC{
    self.isCanScroll = YES;
    self.descriptionVC = [JobDetailDescriptionViewController new];
    self.companyVC = [JobDetailCompanyViewController new];
    self.reviewsVC = [JobDetailReviewsViewController new];
    
    
    WeakSelf;
    self.descriptionVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.companyVC.isCanScroll = NO;
        [weakSelf.companyVC contentOffsetToPointZero];
        weakSelf.reviewsVC.isCanScroll = NO;
        [weakSelf.reviewsVC contentOffsetToPointZero];
        
    };
    self.companyVC.noScrollAction = ^{
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
        weakSelf.companyVC.isCanScroll = NO;
        [weakSelf.companyVC contentOffsetToPointZero];
    };
}


-(UIView*)tableContentView{
    if(!_tableContentView){
        int height = [self tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        _tableContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,height)];
        
        self.descriptionVC.view.frame = _tableContentView.frame;
        [self.descriptionVC setData:jobModel.jobDescription];
        [_tableContentView addSubview:self.descriptionVC.view];
        
        
        self.companyVC.view.frame = _tableContentView.frame;
        [self.companyVC setData:jobModel.dso];
        [_tableContentView addSubview:self.companyVC.view];
        
        
        self.reviewsVC.view.frame = _tableContentView.frame;
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
            self.companyVC.view.hidden = YES;
            self.reviewsVC.view.hidden = YES;
            break;
        case 1:
            self.descriptionVC.view.hidden = YES;
            self.companyVC.view.hidden = NO;
            self.reviewsVC.view.hidden = YES;
            break;
        case 2:
            self.descriptionVC.view.hidden = YES;
            self.companyVC.view.hidden = YES;
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
        [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:0]bottomParent:0]  install];
        tabView.titleArr=[NSMutableArray arrayWithArray:@[@"DESCRIPTION",@"COMPANY",@"REVIEWS"]];
        
    }
    return sectionHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREENHEIGHT - navBarOffset - navBarHeight - 50;
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
            self.companyVC.isCanScroll = YES;
            [self.companyVC contentOffsetToPointZero];
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


@end
