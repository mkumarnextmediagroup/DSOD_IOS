//
//  UniteThumCollectionViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UniteThumCollectionViewCell.h"
#import "Common.h"
@interface UniteThumCollectionViewCell()<UIScrollViewDelegate,UIWebViewDelegate>{
    
    UIView *contentView;
    UIView *lastView;
    
    UIImageView *imageView;
    
    DetailModel *detailModel;
    
    
    CGFloat lastContentOffset;
    UIWebView *mywebView;
}

@end
@implementation UniteThumCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self layoutIfNeeded];
//        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _scrollView.delegate=self;
//        [self addSubview:_scrollView];
//        [_scrollView setContentOffset:CGPointMake(0, 0)];
//        _scrollView.contentInset = UIEdgeInsetsMake(NAVHEIGHT, 0.0f, 0.0f, 0.0f);
//        if (@available(iOS 11.0, *)) {
//            //设置不自动偏移
//            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // Fallback on earlier versions
//        }
//        contentView = _scrollView.addView;
//        [contentView layoutFill];
//        [[contentView.layoutUpdate widthEq:frame.size.width] install];
//
//
//        [self buildView];
//        [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(lastView) install];
        mywebView = [UIWebView new];
        mywebView.delegate = self;
        mywebView.scrollView.delegate=self;
        mywebView.scrollView.scrollEnabled = YES;
        if (@available(iOS 11.0, *)) {
            //设置不自动偏移
            mywebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [mywebView.scrollView setContentOffset:CGPointMake(0, 0)];
        mywebView.scrollView.contentInset = UIEdgeInsetsMake(NAVHEIGHT, 0.0f, 0.0f, 0.0f);
        [self addSubview:mywebView];
        [[[[[mywebView.layoutMaker leftParent:10] rightParent:10] topParent:0] bottomParent:0] install];
    }
    return self;
}

-(void)buildView{
    imageView = contentView.addImageView;
    [imageView scaleFillAspect];
    imageView.clipsToBounds = YES;
    [[[[[imageView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:SCREENWIDTH] install];
    
    
    imageView.image = [UIImage imageNamed:@"unitedetail3"];
    
    
    
    lastView = imageView;
}


-(void)bind:(DetailModel*)model{
    detailModel = model;
    [[mywebView.layoutUpdate heightEq:1] install];
    [mywebView loadHTMLString:[self htmlString:model.content] baseURL:nil];


//    [[imageView.layoutUpdate heightEq:7970* SCREENWIDTH/750]install];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //禁止用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    //禁止长按弹出选择框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [[mywebView.layoutUpdate heightEq:webViewHeight] install];
    //    CGFloat webViewHeight1 =[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    //
    //    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    //    CGFloat webViewHeight2 = actualSize.height;
    ////
    //    NSLog(@"%f------%f-------%f",webViewHeight,webViewHeight1,webViewHeight2);
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(UniteThumCollectionViewCellScroview:)]){
        [self.delegate UniteThumCollectionViewCellScroview:scrollView.contentOffset.y];
        
      
        
        
        BOOL show = YES;
        CGFloat newY= scrollView.contentOffset.y;
        NSLog(@"newY:===%f", newY);
        if (newY < 0) {
            show = NO;
        }else{
            if (newY != lastContentOffset ) {
                if (newY > lastContentOffset) { // scroll下滑...
                    show = YES;
                    
                }else{  // scroll上滑...
                    show = NO;
                    
                }
                lastContentOffset = newY;   // 记录上一次的偏移量
            }
        }
        
       [self.delegate toggleNavBar:show];// 刷新状态栏的隐藏状态
    }
}

- (NSString *)htmlString:(NSString *)html
{
    NSString *htmlString = [NSString stringWithFormat:@"%@%@%@%@%@ %@%@%@%@%@ %@",
                            @"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'>",
                            @"<style type=\"text/css\">",
                            @"body{padding:0px;margin:0px;background:#fff;font-family:SFUIText-Regular;}",
                            @"p{width:100%;margin: 10px auto;color:#4a4a4a;font-size:0.9em;}",
                            @"em{font-style:normal}",
                            @".first-big p:first-letter{float: left;font-size:1.9em;padding-right:8px;text-transform:uppercase;color:#4a4a4a;}",
                            @"blockquote{color:#4a4a4a;font-size:1.2em;font-weight:bold;margin: 20px 10px 10px 25px;position:relative;line-height:110%;text-indent:0px}",
                            @"blockquote:before{color:#4a4a4a;font-family:PingFangTC-Regular;content:'“';font-size:1.6em;position:absolute;left:-20px;top:15px;line-height:.1em}",
                            //@"blockquote:after{color:#4a4a4a;content:'”';font-size:5em;position:absolute;right:15px;bottom:0;line-height:.1em}"
                            @"figure{ margin:0 auto; background:#fff; }",
                            @"figure img{width:100%;height:''} img{width:100%;height:auto}",
                            @"</style>"
                            ];
    
    
    html = [html stringByReplacingOccurrencesOfString :@"pre" withString:@"blockquote"];
    html = [html stringByReplacingOccurrencesOfString :@"<p>&nbsp;</p>" withString:@""];
    //    html = [self htmlRemoveReferences:html];
    
    BOOL isFirst = YES;
    NSArray *array = [html componentsSeparatedByString:@"<p>"];
    for (int i = 0; i < [array count]; i++) {
        NSString *currentString = [array objectAtIndex:i];
        if(i>0){
            if([currentString rangeOfString:@"<iframe"].location !=NSNotFound){
                continue;
            }
            if(isFirst){
                //错误格式兼容<strong> </strong>厉害了中间还不是空格
                //                 htmlString = [htmlString stringByReplacingOccurrencesOfString :@"<strong> </strong>" withString:@""];
                htmlString = [NSString stringWithFormat:@"%@<div class='first-big'><p>%@</div>",htmlString,currentString];
                isFirst = NO;
            }else{
                htmlString = [NSString stringWithFormat:@"%@<p>%@",htmlString,currentString];
            }
        }
    }
    
    //地址跳转测试
    //    htmlString = [NSString stringWithFormat:@"%@%@",htmlString,@"<p><a href=\"dsodentistapp://com.thenextmediagroup.dentist/openCMSDetail?articleId=5be29d5f0e88c608b8186e52\">Converting Invisalign brand online consumers to new patients</a></p>"];
    
    htmlString = [NSString stringWithFormat:@"%@%@%@%@",
                  htmlString,
                  @"<script type=\"text/javascript\">",
                  @"var figureArr = document.getElementsByTagName('figure');",
                  @"for (let i = 0;i < figureArr.length;i++){figureArr[i].style.width = '100%'}"
                  @"</script>"
                  ];
    
    return htmlString;
}

@end
