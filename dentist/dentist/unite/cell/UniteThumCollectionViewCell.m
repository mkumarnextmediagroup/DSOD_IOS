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
        mywebView.scrollView.showsVerticalScrollIndicator=NO;
        mywebView.scrollView.showsHorizontalScrollIndicator=YES;
        mywebView.backgroundColor=[UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            //设置不自动偏移
            mywebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [mywebView.scrollView setContentOffset:CGPointMake(0, 0)];
        mywebView.scrollView.contentInset = UIEdgeInsetsMake(NAVHEIGHT, 0.0f, 0.0f, 0.0f);
        [self addSubview:mywebView];
//        mywebView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
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
    
    [mywebView loadHTMLString:[NSString webHtmlString:model.content] baseURL:nil];


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

@end
