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
#import "MagazineModel.h"

@interface UniteThumCollectionViewCell()<UIScrollViewDelegate,UIWebViewDelegate>{
    
    UIView *contentView;
    UIView *lastView;
    
    
    UIImageView *imageView;
    UIWebView *mywebView;
    
    UIView *swipeView;
    
    DetailModel *detailModel;
    
    CGFloat lastContentOffset;
    
    
    int edge;
    int imageViewHeight;
    int imageViewCoverHeight;
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
        
        imageViewHeight = SCREENWIDTH * 2 /3;
        imageViewCoverHeight = SCREENHEIGHT * 3 / 4;
        
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
    [[[[[imageView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:imageViewHeight] install];
    
    
    [self buildSwipeView];
    
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    mywebView.userInteractionEnabled = NO;
    mywebView.backgroundColor=[UIColor clearColor];
    [self addSubview:mywebView];
    [[[[[mywebView.layoutMaker leftParent:edge] rightParent:-edge] below:imageView offset:10] heightEq:1] install];
    
    
    
    
    
    lastView = mywebView;
}

-(void)buildSwipeView{
    swipeView  = self.addView;
    [[[[swipeView.layoutMaker below:imageView offset:20] centerXParent:0] heightEq:50] install];
    swipeView.hidden = YES;
    
    UILabel *leftLabel = swipeView.addLabel;
    leftLabel.textColor = UIColor.whiteColor;
    leftLabel.font = [Fonts semiBold:30];
    leftLabel.text = @"<";
    
    UILabel *swipeLabel = swipeView.addLabel;
    swipeLabel.textColor = UIColor.whiteColor;
    swipeLabel.font = [Fonts semiBold:20];
    swipeLabel.text = @"Swipe between articles";
    
    UILabel *rightLabel = swipeView.addLabel;
    rightLabel.textColor = UIColor.whiteColor;
    rightLabel.font = [Fonts semiBold:30];
    rightLabel.text = @">";
    
    [[swipeLabel.layoutMaker centerParent] install];
    [[[leftLabel.layoutMaker toLeftOf:swipeLabel offset:-10 ] centerYParent:0] install];
    [[[rightLabel.layoutMaker toRightOf:swipeLabel offset:10] centerYParent:0] install];
}


-(void)bind:(id)model{
    if ([model isKindOfClass:[DetailModel class]]) {
        detailModel = (DetailModel *)model;
    
       swipeView.hidden = YES;
       [[mywebView.layoutUpdate heightEq:1] install];
    
        if([detailModel.uniteArticleType isEqualToString:@"1"]){
            [self showCover:detailModel.magazineModel];
            
        }else if([detailModel isKindOfClass:[DetailModel class]]){
            [self showActicle:(DetailModel *)model];
        }
        
        
    }
    
}
    
-(void)showCover:(MagazineModel*)model{
    self.backgroundColor = UIColor.blackColor;

    NSString* cover = model.cover;
    [imageView loadUrl:cover placeholderImage:@""];
    [[imageView.layoutUpdate heightEq:imageViewCoverHeight ]install];

    swipeView.hidden = NO;
}

-(void)showActicle:(DetailModel*)model{
    self.backgroundColor = UIColor.whiteColor;
    
    NSString* type = model.featuredMedia[@"type"];
    if([type isEqualToString:@"1"] ){
        //pic
        NSDictionary *codeDic = model.featuredMedia[@"code"];
        NSString *urlstr = codeDic[@"thumbnailUrl"];
        [imageView loadUrl:urlstr placeholderImage:@""];
    }
    
    
    [mywebView loadHTMLString:[NSString webHtmlString:model.content] baseURL:nil];
    
    [[imageView.layoutUpdate heightEq:imageViewHeight ]install];
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
        
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(hideNavBar:)]){
        BOOL hide = NO;
        CGFloat newY= scrollView.contentOffset.y;
//        NSLog(@"newY:===%f", newY);
        if (newY < -2) {
            hide = NO;
        }else if (newY != lastContentOffset ) {
            if (newY > lastContentOffset) {
                hide = YES;
                
            }else{
                hide = NO;
                
            }
            lastContentOffset = newY;
        }
        
        [self.delegate hideNavBar:hide];
    }
    
}

@end
