//
//  UniteThumCollectionViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UniteThumCollectionViewCell.h"
#import "Common.h"
#import "NSString+myextend.h"
@interface UniteThumCollectionViewCell()<UIScrollViewDelegate,UIWebViewDelegate>{
    
    UIView *contentView;
    UIView *lastView;
    
    
    UIImageView *imageView;
    UIWebView *mywebView;
    
    DetailModel *detailModel;
    
    CGFloat lastContentOffset;
    int edge;
}

@end
@implementation UniteThumCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        edge = 18;
        if(IS_IPHONE_P_X){
            edge=24;
        }
        
        self.backgroundColor=[UIColor whiteColor];
        [self layoutIfNeeded];
        
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate=self;
        [self addSubview:_scrollView];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        _scrollView.contentInset = UIEdgeInsetsMake(NAVHEIGHT, 0.0f, 0.0f, 0.0f);
        if (@available(iOS 11.0, *)) {
            //设置不自动偏移
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        contentView = _scrollView.addView;
        [contentView layoutFill];
        [[contentView.layoutUpdate widthEq:frame.size.width] install];


        [self buildView];
        [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(lastView) install];
        
        

    }
    return self;
}

-(void)buildView{
    imageView = contentView.addImageView;
    [imageView scaleFillAspect];
    imageView.clipsToBounds = YES;
    [[[[[imageView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:SCREENWIDTH * 2 /3] install];
    
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
//    mywebView.scrollView.delegate=self;
    mywebView.scrollView.scrollEnabled = NO;
    mywebView.userInteractionEnabled = NO;
//    mywebView.scrollView.showsVerticalScrollIndicator=NO;
//    mywebView.scrollView.showsHorizontalScrollIndicator=NO;
    mywebView.backgroundColor=[UIColor clearColor];
    [self addSubview:mywebView];
    [[[[[mywebView.layoutMaker leftParent:edge] rightParent:-edge] below:imageView offset:10] heightEq:1] install];
    
    
    
    
    
    lastView = mywebView;
}


-(void)bind:(DetailModel*)model{
    detailModel = model;
    
    
    NSString* type = model.featuredMedia[@"type"];
    if([type isEqualToString:@"1"] ){
        //pic
        NSDictionary *codeDic = model.featuredMedia[@"code"];
        NSString *urlstr = codeDic[@"thumbnailUrl"];
        [imageView loadUrl:urlstr placeholderImage:@""];
    }
    
    [[mywebView.layoutUpdate heightEq:1] install];
    [mywebView loadHTMLString:[NSString webHtmlString:model.content] baseURL:nil];



//    [[imageView.layoutUpdate heightEq:7970* SCREENWIDTH/750]install];
    
}


#pragma mark ---UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //禁止用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    //禁止长按弹出选择框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [[mywebView.layoutUpdate heightEq:webViewHeight] install];
    
}

#pragma mark ---UIScrollViewDelegate
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

@end
