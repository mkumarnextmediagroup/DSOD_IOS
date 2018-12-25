//
//  CompanyReviewsDetailViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/23.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyReviewsDetailViewController.h"
#import "Common.h"
#import "XHStarRateView.h"

@interface CompanyReviewsDetailViewController ()

@property (nonatomic,strong) CompanyReviewModel *reviewModel;
@property (nonatomic,strong) JobDSOModel *jobDSOModel;

@end


@implementation CompanyReviewsDetailViewController{
    int edge;
    UIScrollView *scrollView;
    UIView *contentView;
    
    XHStarRateView *starRateView;
    UILabel *reviewTitleLabel;
    UILabel *reviewDateLabel;
    UILabel *currentEmployeeLabel;
    UILabel *prosValueLabel;
    UILabel *consValueLabel;
    UILabel *adviceValueLabel;
    
    UIButton *recommendsBtn;
    UIButton *approveBtn;
    
}

+(void)openBy:(UIViewController*)vc jobDSOModel:(JobDSOModel*)jobDSOModel companyReviewModel:(CompanyReviewModel*)reviewModel{
    CompanyReviewsDetailViewController *reviewDetailVc = [CompanyReviewsDetailViewController new];
    reviewDetailVc.reviewModel = reviewModel;
    reviewDetailVc.jobDSOModel = jobDSOModel;
    [vc pushPage:reviewDetailVc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self addNavBar];
    
    [self buildViews];
    
    [self loadData];
}


-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = self.jobDSOModel.name;
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    
}

-(void)buildViews{
    scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView layoutFill];
    [[scrollView.layoutUpdate topParent:NAVHEIGHT]install];
    
    
    contentView = scrollView.addView;
    [[[[[[contentView.layoutMaker topParent:0]leftParent:0] rightParent:0] bottomParent:0]widthEq:SCREENWIDTH] install];
    
    reviewTitleLabel = contentView.addLabel;
    reviewTitleLabel.textColor = rgbHex(0x1b1b1b);
    reviewTitleLabel.font = [Fonts regular:13];
    [[[[reviewTitleLabel.layoutMaker leftParent:edge] topParent:edge] rightParent:-edge]install];
    
    UIView *starRateViewBg = contentView.addView;
    [[[[starRateViewBg.layoutUpdate below:reviewTitleLabel offset:10]leftParent:edge]heightEq:15] install];
    
    starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0 , 0, 80, 15)];
    starRateView.isAnimation = NO;
    starRateView.userInteractionEnabled = NO;
    starRateView.rateStyle = HalfStar;
    [starRateViewBg addSubview:starRateView];
    
    
    currentEmployeeLabel = contentView.addLabel;
    currentEmployeeLabel.textColor = rgbHex(0x787878);
    currentEmployeeLabel.font = [Fonts regular:12];
    [[[currentEmployeeLabel.layoutMaker leftParent:edge] below:starRateViewBg offset:10] install];
    
    reviewDateLabel = contentView.addLabel;
    reviewDateLabel.textColor = rgbHex(0xbababa);
    reviewDateLabel.font = [Fonts regular:12];
    [[[reviewDateLabel.layoutMaker rightParent:-edge] below:starRateViewBg offset:10] install];
    
    UILabel *lineLabel = contentView.lineLabel;
    [[[[[lineLabel.layoutMaker below:currentEmployeeLabel offset:edge]leftParent:0]rightParent:0]heightEq:1] install];
    
    UILabel *prosLabel = contentView.addLabel;
    prosLabel.text = @"Pros";
    prosLabel.textColor = rgbHex(0x4a4a4a);
    prosLabel.font = [Fonts regular:14];
    [[[[prosLabel.layoutMaker leftParent:edge] below:lineLabel offset:edge] rightParent:-edge]install];
    
    prosValueLabel = contentView.addLabel;
    prosValueLabel.textColor = rgbHex(0x9b9b9b);
    prosValueLabel.font = [Fonts regular:13];
    [[[[prosValueLabel.layoutMaker leftParent:edge] below:prosLabel offset:5] rightParent:-edge]install];
    
    UILabel *consLabel = contentView.addLabel;
    consLabel.text = @"Cons";
    consLabel.textColor = rgbHex(0x4a4a4a);
    consLabel.font = [Fonts regular:14];
    [[[[consLabel.layoutMaker leftParent:edge] below:prosValueLabel offset:edge] rightParent:-edge]install];
    
    consValueLabel = contentView.addLabel;
    consValueLabel.textColor = rgbHex(0x9b9b9b);
    consValueLabel.font = [Fonts regular:13];
    [[[[consValueLabel.layoutMaker leftParent:edge] below:consLabel offset:5] rightParent:-edge]install];
    
    
    UILabel *adviceLabel = contentView.addLabel;
    adviceLabel.text = @"Advice";
    adviceLabel.textColor = rgbHex(0x4a4a4a);
    adviceLabel.font = [Fonts regular:14];
    [[[[adviceLabel.layoutMaker leftParent:edge] below:consValueLabel offset:edge] rightParent:-edge]install];
    
    adviceValueLabel = contentView.addLabel;
    adviceValueLabel.textColor = rgbHex(0x9b9b9b);
    adviceValueLabel.font = [Fonts regular:13];
    [[[[adviceValueLabel.layoutMaker leftParent:edge] below:adviceLabel offset:5] rightParent:-edge]install];
    
    
    approveBtn = contentView.addButton;
    approveBtn.titleLabel.font = [Fonts regular:12];
    [approveBtn setTitleColor:rgbHex(0x1b1b1b) forState:UIControlStateNormal];
    [approveBtn setTitle:@" Approve of CEO" forState:UIControlStateNormal];
    [approveBtn setImage:[UIImage imageNamed:@"icon_check_mark_small"] forState:UIControlStateNormal];
    approveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [[[[approveBtn.layoutMaker below:adviceValueLabel offset:0] rightParent:-edge]heightEq:40] install];
    
    
    recommendsBtn = contentView.addButton;
    recommendsBtn.titleLabel.font = [Fonts regular:12];
    [recommendsBtn setTitleColor:rgbHex(0x1b1b1b) forState:UIControlStateNormal];
    [recommendsBtn setTitle:@" Recommends" forState:UIControlStateNormal];
    [recommendsBtn setImage:[UIImage imageNamed:@"icon_check_mark_small"] forState:UIControlStateNormal];
    recommendsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [[[[recommendsBtn.layoutMaker below:adviceValueLabel offset:0]toLeftOf:approveBtn offset:-edge]heightEq:40] install];
    
    [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(recommendsBtn) install];
}

-(void)loadData{
    
    reviewTitleLabel.text = [NSString stringWithFormat:@"“%@”",self.reviewModel.reviewTitle];
    reviewDateLabel.text = [NSDate USDateShortFormatWithTimestamp:self.reviewModel.reviewDate];
    starRateView.currentScore = self.reviewModel.rating;
    
    if(self.reviewModel.isCurrentEmployee){
        currentEmployeeLabel.text = @"Current Employee - Anonymous Employee";
    }else if(self.reviewModel.isFormerEmployee){
        currentEmployeeLabel.text = @"Former Employee - Anonymous Employee";
    }else{
        currentEmployeeLabel.text = @"Anonymous Employee";
    }
    prosValueLabel.text = self.reviewModel.pros;
    consValueLabel.text = self.reviewModel.cons;
    adviceValueLabel.text = self.reviewModel.advice;
    
    
    if(!self.reviewModel.isRecommend){
        [[recommendsBtn.layoutUpdate widthEq:0]install];
    }
    if(!self.reviewModel.isApprove){
        [[approveBtn.layoutUpdate widthEq:0]install];
    }
    
    
}
@end
