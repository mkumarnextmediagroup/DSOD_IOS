//
//  CareerJobDetailViewController.m
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerJobDetailViewController.h"
#import "common.h"
#import "UIView+Toast.h"
#import "CompanyOfJobDetailTableViewCell.h"
#import "DescriptionOfJobDetailTableViewCell.h"
#import "CompanyReviewHeaderTableViewCell.h"
#import "CompanyReviewTableViewCell.h"
#import "CompanyModel.h"
#import "Proto.h"
#import "JobModel.h"
#import "DentistTabView.h"
#import "BannerScrollView.h"
#import "CompanyMediaModel.h"
#import "CompanyCommentReviewsModel.h"
#import "DentistDataBaseManager.h"
#import "DsoToast.h"

@interface CareerJobDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate>

@end

@implementation CareerJobDetailViewController{
    
    UIView *contentView;
    UIView *naviBarView;
    UITableView *tableView;
    
    BannerScrollView *bannerView;
    UIImageView *singleImageView;
    UIWebView *vedioWebView;
    
    UIView *sectionHeaderView;
    
    int edge;
    int currTabIndex;//0:description 1:company 2:reviews
    
    JobModel *jobModel;
    CompanyCommentModel *companyCommentModel;
    NSArray<CompanyCommentReviewsModel*> *commentArray;
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
    
    CareerJobDetailViewController *jobDetailVc = [CareerJobDetailViewController new];
    jobDetailVc.jobId =jobId;
    jobDetailVc.closeBack = closeBack;
    jobDetailVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    jobDetailVc.view.backgroundColor = UIColor.clearColor;
    viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [viewController presentViewController:jobDetailVc animated:YES completion:^{
        jobDetailVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }];
}

- (void)viewDidLoad {
    edge = 18;
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    contentView  = self.view.addView;
    [[[[[contentView.layoutMaker leftParent:0]rightParent:0] topParent:44]bottomParent:0] install];
    contentView.backgroundColor = UIColor.whiteColor;
    
    [self addNavBar];
    
    [self showLoading];
    
    [Proto findJobById:self.jobId completed:^(JobModel * _Nullable jobModel) {
        [self hideLoading];
        if(jobModel){
            self->jobModel = jobModel;
            [self buildView];
        }
    }];
}

-(void)addNavBar{
    naviBarView = contentView.addView;
    naviBarView.backgroundColor = Colors.textDisabled;
    [[[naviBarView.layoutMaker sizeEq:SCREENWIDTH h:44] topParent:0]install];
    
    UIImageView *closeView = naviBarView.addImageView;
    closeView.image = [UIImage imageNamed:@"icon_arrow_down"];
    [closeView onClickView:self action:@selector(closePage)];
    [[[closeView.layoutMaker sizeEq:100 h:40]centerParent]install];
    
    UIImageView *shareView = naviBarView.addImageView;
    shareView.image = [UIImage imageNamed:@"icon_share_white"];
    [shareView onClickView:self action:@selector(share)];
    [[[[shareView.layoutMaker sizeEq:44 h:44] centerYParent:0] rightParent:-5] install];


    UIImageView *attentionView = naviBarView.addImageView;
    attentionView.image = [UIImage imageNamed:@"icon_attention"];
    [attentionView onClickView:self action:@selector(attention)];
    [[[[attentionView.layoutMaker sizeEq:44 h:44]centerYParent:0]toLeftOf:shareView offset:0] install];
    

}


-(void)buildView{
    tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
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
    if(jobModel.company.media){
        NSArray *urls = jobModel.company.media.companyPictureUrl;
        NSArray *code = jobModel.company.media.code;
        if(jobModel.company.media.type == 1 && urls && urls.count > 0 ){
            if(urls.count>1){
                bannerView.hidden = NO;
                [bannerView addWithImageUrls:urls autoTimerInterval:3 clickBlock:^(NSInteger index) {
                    
                }];
            }else{
                singleImageView.hidden = NO;
                [singleImageView loadUrl:urls[0] placeholderImage:nil];
            }
        }else if(jobModel.company.media.type == 2 && code && code.count > 0) {
            vedioWebView.hidden = NO;
            [self showVideo:code[0]];
        }
    }
    
    
    [logoImageView loadUrl:jobModel.company.companyLogoUrl placeholderImage:nil];
    
    jobLabel.text = [NSString stringWithFormat:@"%@ - %@",jobModel.jobTitle,jobModel.location];
    companyLabel.text = jobModel.company.companyName;
    
    NSInteger startsalary=ceilf(jobModel.salaryStartingValue/1000.0);
    NSInteger endsalary=ceilf(jobModel.salaryEndValue/1000.0);
    salaryLabel.text=[NSString stringWithFormat:@"Est. Salary: $%@k-$%@k",@(startsalary),@(endsalary)];
    [addressBtn setTitle:jobModel.address forState:UIControlStateNormal];
    
    

    
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
    [self.view makeToast:@"showLocation"];
}

-(void)attention{
     [self.view makeToast:@"attention"];
}

-(void)share{
     [self.view makeToast:@"share"];
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


#pragma mark DentistTabViewDelegate
- (void)didDentistSelectItemAtIndex:(NSInteger)index{
    currTabIndex = (int)index;
    [tableView reloadData];
    
    if(commentArray && currTabIndex == 2){
        [self showLoading];
        [Proto findCommentByCompanyId:jobModel.companyId sort:0 star:0 skip:0 limit:2 completed:^(CompanyCommentModel * _Nullable companyCommentModel) {
            [self hideLoading];
            self->companyCommentModel = companyCommentModel;
            self->commentArray = companyCommentModel.reviews;
            [self->tableView reloadData];
        }];
    }
}


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
    switch (currTabIndex) {
        case 0:
            return 1 ;
        case 1:
            return 1;
        case 2:
            return companyCommentModel && commentArray ?commentArray.count+1:0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    
    switch (currTabIndex) {
        case 0:
            return [self descriptionOfJobDetailCell:tableView data:self->jobModel];
        case 1:
            return [self companyOfJobDetailTableViewCell:tableView data:self->jobModel.company];
        case 2:
            if(indexPath.row == 0){
                return [self companyReviewHeaderCell:tableView data:self->companyCommentModel];
            }else{
                return [self companyReviewTableViewCell:tableView data:self->commentArray[indexPath.row-1]];
            }
        default:
            break;
    }
    
   
    return cell;
}

-(UITableViewCell*)descriptionOfJobDetailCell:tableView data:(JobModel*)model{
    DescriptionOfJobDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionOfJobDetailTableViewCell"];
    if (cell == nil) {
        cell = [[DescriptionOfJobDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionOfJobDetailTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tableView = tableView;
    [cell setData:model];
    return cell;
}


-(UITableViewCell*)companyOfJobDetailTableViewCell:tableView data:(CompanyModel*)model{
    CompanyOfJobDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyOfJobDetailTableViewCell"];
    if (cell == nil) {
        cell = [[CompanyOfJobDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyOfJobDetailTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:model];
    return cell;
}

-(UITableViewCell*)companyReviewHeaderCell:tableView data:(CompanyCommentModel*)model{
    CompanyReviewHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyReviewHeaderTableViewCell"];
    if (cell == nil) {
        cell = [[CompanyReviewHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyReviewHeaderTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:model];
    return cell;
}

-(UITableViewCell*)companyReviewTableViewCell:tableView data:(CompanyCommentReviewsModel*)model{
    CompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyReviewTableViewCell"];
    if (cell == nil) {
        cell = [[CompanyReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyReviewTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
