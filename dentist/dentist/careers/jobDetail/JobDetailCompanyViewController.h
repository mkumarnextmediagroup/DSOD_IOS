//
//  JobDetailCompanyViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailCompanyViewController : UIViewController


// 是否可以滑动
//Is it currently possible to scroll
@property (nonatomic, assign) BOOL isCanScroll;
// 不滑动事件
// Callback function when scrolling is not possible
@property (nonatomic, copy) void(^noScrollAction)(void) ;

/**
 滚动到初始位置
 Scroll to the initial position
 */
- (void)contentOffsetToPointZero;

/**
 set data

 @param model JobDSOModel
 */
- (void)setData:(JobDSOModel* _Nullable)model;

/**
 view did load
 */
- (void)viewDidLoad;

/**
 UIWebViewDelegate
 webview did finish load

 @param webView UIWebView
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView;

/**
 UIScrollViewDelegate
 scroll view did scroll

 @param scrollView UIScrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
