//
//  JobDetailCompanyViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JobDetailCompanyViewController.h"
#import "Common.h"
#import "NSString+htmlStyle.h"

@interface JobDetailCompanyViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

@end

@implementation JobDetailCompanyViewController {
    UIScrollView *scrollView;
    UIView *contentView;
    UIView *lastView;
    
    UILabel *websiteValueLabel;
    UILabel *yearOfFoundationValueLabel;
    UILabel *numOfEmployeesValueLabel;
    UILabel *stageValueLabel;
    UILabel *contactPersonValueLabel;
    UIWebView *detailWebView;
    
    int edge;
}

/**
 view did load
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    edge = 18;
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollView.delegate=self;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    [[[[[scrollView.layoutMaker topParent:0]leftParent:0]rightParent:0] bottomParent:0] install];
    if (@available(iOS 11.0, *)) {
        //设置不自动偏移
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    contentView = scrollView.addView;
    [[[[[contentView.layoutMaker topParent:0]leftParent:0] widthEq:SCREENWIDTH] bottomParent:0] install];
    

    [self buildView];


    [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(lastView) install];
}


/**
 build views
 */
-(void)buildView{
    
    //Website
    UILabel *websiteLabel = contentView.addLabel;
    websiteLabel.text = @"Website";
    websiteLabel.font = [Fonts regular:14];
    websiteLabel.numberOfLines = 1;
    [[[[websiteLabel.layoutMaker leftParent:edge]topParent:0] sizeEq:70 h:50]install];
    
    
    websiteValueLabel = contentView.addLabel;
    websiteValueLabel.textColor = Colors.textDisabled;
    websiteValueLabel.font = [Fonts regular:14];
    websiteValueLabel.textAlignment = NSTextAlignmentRight;
    websiteValueLabel.lineBreakMode = NSLineBreakByCharWrapping;
    websiteValueLabel.numberOfLines = 3;
    [[[[websiteValueLabel.layoutMaker toRightOf:websiteLabel offset:0]rightParent:-edge]  centerYOf:websiteLabel offset:0] install];
    
    
    
    //Year of Foundation
    UILabel *yearOfFoundationLabel = contentView.addLabel;
    yearOfFoundationLabel.text = @"Year of Foundation";
    yearOfFoundationLabel.font = [Fonts regular:14];
    [[[[yearOfFoundationLabel.layoutMaker leftParent:edge]below:websiteLabel offset:0]heightEq:50]install];
    
    yearOfFoundationValueLabel = contentView.addLabel;
    yearOfFoundationValueLabel.textColor = Colors.textDisabled;
    yearOfFoundationValueLabel.font = [Fonts regular:14];
    yearOfFoundationValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[yearOfFoundationValueLabel.layoutMaker toRightOf:yearOfFoundationLabel offset:edge]below:websiteLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //No. of Employees
    UILabel *numOfEmployeesLabel = contentView.addLabel;
    numOfEmployeesLabel.text = @"No. of Employees";
    numOfEmployeesLabel.font = [Fonts regular:14];
    [[[[numOfEmployeesLabel.layoutMaker leftParent:edge]below:yearOfFoundationLabel offset:0]heightEq:50]install];
    
    numOfEmployeesValueLabel = contentView.addLabel;
    numOfEmployeesValueLabel.textColor = Colors.textDisabled;
    numOfEmployeesValueLabel.font = [Fonts regular:14];
    numOfEmployeesValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[numOfEmployeesValueLabel.layoutMaker toRightOf:numOfEmployeesLabel offset:edge]below:yearOfFoundationLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //Stage
    UILabel *stageLabel = contentView.addLabel;
    stageLabel.text = @"Stage";
    stageLabel.font = [Fonts regular:14];
    [[[[stageLabel.layoutMaker leftParent:edge]below:numOfEmployeesLabel offset:0]heightEq:50]install];
    
    stageValueLabel = contentView.addLabel;
    stageValueLabel.textColor = Colors.textDisabled;
    stageValueLabel.font = [Fonts regular:14];
    stageValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[stageValueLabel.layoutMaker toRightOf:stageLabel offset:edge]below:numOfEmployeesLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //Contact Person
    UILabel *contactPersonLabel = contentView.addLabel;
    contactPersonLabel.text = @"Contact Person";
    contactPersonLabel.font = [Fonts regular:14];
    [[[[contactPersonLabel.layoutMaker leftParent:edge]below:stageLabel offset:0]heightEq:50]install];
    
    
    contactPersonValueLabel = contentView.addLabel;
    contactPersonValueLabel.textColor = Colors.textDisabled;
    contactPersonValueLabel.font = [Fonts regular:14];
    contactPersonValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[contactPersonValueLabel.layoutMaker toRightOf:contactPersonLabel offset:edge]below:stageLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    
    //Details
    UILabel *detailLabel = contentView.addLabel;
    detailLabel.text = @"Details";
    detailLabel.font = [Fonts regular:14];
    detailLabel.textColor = rgbHex(0xB3B9BD);
    [[[[detailLabel.layoutMaker leftParent:edge]rightParent:-edge] below:contactPersonLabel offset:15] install];
    
    
    detailWebView = [UIWebView new];
    detailWebView.delegate = self;
    detailWebView.scrollView.delegate = self;
    detailWebView.scrollView.scrollEnabled = NO;
    detailWebView.userInteractionEnabled = YES;
    detailWebView.backgroundColor=[UIColor clearColor];
    [contentView addSubview:detailWebView];
    [[[[[[detailWebView.layoutMaker leftParent:0]rightParent:0] below:detailLabel offset:0]bottomParent:-80]heightEq:1] install];
    
    
    
    
    lastView = detailWebView;
}

/**
 set data
 
 @param model JobDSOModel
 */
- (void)setData:(JobDSOModel *)model{
    
    
    websiteValueLabel.text = model.url;
    yearOfFoundationValueLabel.text =  model.year_of_foundation;
    numOfEmployeesValueLabel.text = model.employees;
    stageValueLabel.text = model.stage;
    contactPersonValueLabel.text = model.ceo;
    [detailWebView loadHTMLString:[NSString career_DescriptionHtml:model.dsoDescription] baseURL:nil];
}


/**
 UIWebViewDelegate
 webview did finish load
 
 @param webView UIWebView
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [[webView.layoutUpdate heightEq:webViewHeight] install];
}

#pragma mark - 滑动方法
/**
 UIScrollViewDelegate
 scroll view did scroll
 
 @param scrollView UIScrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    /// 当偏移量小于0时，不能滑动，并且使主要视图的UITableView滑动
    if (scrollView.contentOffset.y < 0 ) {
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        if (self.noScrollAction) {
            self.noScrollAction();
        }
    }
}

/**
 UIScrollViewDelegate
 scroll view did scroll
 
 @param scrollView UIScrollView
 */
-(void)contentOffsetToPointZero{
    scrollView.contentOffset = CGPointZero;
}

@end
