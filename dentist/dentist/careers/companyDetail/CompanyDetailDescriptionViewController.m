//
//  CompanyDetailDescriptionViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyDetailDescriptionViewController.h"
#import "Common.h"
#import "JobModel.h"
#import "NSString+htmlStyle.h"

@interface CompanyDetailDescriptionViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation CompanyDetailDescriptionViewController {
    
    UIWebView *mywebView;
    UIView *lastView ;
    
    
    int edge;
    
}


/**
 view did load
 */
- (void)viewDidLoad{
    edge = 18;
    [self buildView];
}


/**
 build views
 */
-(void)buildView{
    edge = 18;
    
    mywebView = [UIWebView new];
    mywebView.scrollView.delegate = self;
    mywebView.scrollView.scrollEnabled = YES;
    mywebView.userInteractionEnabled = YES;
    mywebView.backgroundColor=[UIColor clearColor];
    mywebView.scrollView.contentInset = [self edgeInsetsMake];
    [self.view addSubview:mywebView];
    [[[[[mywebView.layoutMaker leftParent:0]rightParent:0] topParent:0]bottomParent:0] install];
    
}

/**
     Get internal padding
     subview overwrite

     @return UIEdgeInsets
*/
-(UIEdgeInsets)edgeInsetsMake{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
 set data

 @param description text
 */
-(void)setData:(NSString*) description{
    if(description){
        [self showContent:description];
    }
}

/**
 show content，load html

 @param html html content
 */
-(void)showContent:(NSString*)html{
    [mywebView loadHTMLString:[NSString career_DescriptionHtml:html] baseURL:nil];
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
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero{
    mywebView.scrollView.contentOffset = CGPointZero;
}

@end
