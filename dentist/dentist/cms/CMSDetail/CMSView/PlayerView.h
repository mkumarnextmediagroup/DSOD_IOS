//
//  PlayerView.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "DetailModel.h"

@interface PlayerView : UIView

@property (nonatomic,strong)SBPlayer *sbPlayer;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *gskBtn;
@property (nonatomic,strong)UIButton *bgBtn;
@property (nonatomic,strong)UIButton *greeBtn;
@property (nonatomic,strong)UIButton *moreButton;
@property (nonatomic,strong)UIButton *markButton;
@property BOOL authorDSODentist;
@property UIWebView *mywebView;

- (void)bind:(DetailModel *)bindInfo;
- (void)resetLayout;
- (NSString *)htmlString:(NSString *)html;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void) handleCompletion:(WKWebView *)webView result:(id _Nullable) result;
- (void) handleCompletionJavaScript:(id _Nullable) result ratio: (CGFloat) ratio;

@end
