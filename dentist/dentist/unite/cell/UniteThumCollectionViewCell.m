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
#import "Proto.h"

@interface UniteThumCollectionViewCell()<UIScrollViewDelegate,UIWebViewDelegate>{
    
    UIView *contentView;
    UIView *lastView;
    
    
    UIImageView *imageView;
    UIView *swipeView;
    UIView *titleView;
    UILabel *titleLabel;
    UILabel *authorLabel;
    UILabel *subTitleLabel;
    UIWebView *mywebView;
    
    
    
    
    int edge;
    int imageViewHeight;
    int imageViewCoverHeight;
    
    DetailModel *detailModel;
    CGFloat lastContentOffset;
    
    NSTimer *calcWebViewHeightTimer;
    int calcWebViewHeightTimes;
    
}


@end
@implementation UniteThumCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        edge = 18;
//        if(IS_IPHONE_P_X){
//            edge=24;
//        }
        
        imageViewHeight = SCREENWIDTH * 2 /3;
        imageViewCoverHeight = SCREENHEIGHT * 3 / 4;
        
        [self layoutIfNeeded];
        
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate=self;
        _scrollView.alwaysBounceVertical = YES;
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
    
    [self buildTitleView];
    
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    mywebView.userInteractionEnabled = NO;
    mywebView.backgroundColor=[UIColor clearColor];
    [contentView addSubview:mywebView];
    [[[[[mywebView.layoutMaker leftParent:0] rightParent:0] below:titleView offset:0] heightEq:1] install];
    
    lastView = mywebView;
    
}

-(void)buildTitleView{
    
    titleView = contentView.addView;
    [[[[titleView.layoutMaker below:imageView offset:0] leftParent:edge]rightParent:-edge] install];
    
    titleLabel = [titleView addLabel];
    titleLabel.font = [Fonts semiBold:16];
    titleLabel.textColor = rgbHex(0x0e78b9);
    titleLabel.numberOfLines = 0;
    [[[[titleLabel.layoutMaker leftParent:0] rightParent:0] topParent:10] install];

    subTitleLabel = [titleView addLabel];
    subTitleLabel.font = [Fonts semiBold:20];
    subTitleLabel.textColor = UIColor.blackColor;
    subTitleLabel.numberOfLines = 0;
    [[[[subTitleLabel.layoutMaker leftParent:0] rightParent:0] below:titleLabel offset:0] install];
    
    authorLabel = [titleView addLabel];
    authorLabel.font = [Fonts semiBold:14];
    authorLabel.textColor = rgbHex(0x9b9b9b);
    authorLabel.numberOfLines = 0;
    [[[[[authorLabel.layoutMaker leftParent:0] rightParent:0] below:subTitleLabel offset:0] bottomParent:0] install];
    
}

-(void)buildSwipeView{
    swipeView  = contentView.addView;
    [[[[[swipeView.layoutMaker below:imageView offset:0] heightEq:80] leftParent:0]rightParent:0]  install];
    swipeView.hidden = YES;
    
    UIImageView *swipeImageView = swipeView.addImageView;
    swipeImageView.image = [UIImage imageNamed:@"Swipe"];
    [[[swipeImageView.layoutMaker sizeEq:250 h:25]centerParent]install];
    
    
}


-(void)bind:(id)model{
   
    if(calcWebViewHeightTimer){
        [calcWebViewHeightTimer invalidate];
        calcWebViewHeightTimer = nil;
        calcWebViewHeightTimes = 0;
    }
    
    
    if ([model isKindOfClass:[DetailModel class]]) {
        detailModel = (DetailModel *)model;
    
        swipeView.hidden = YES;
        [[titleView.layoutUpdate heightEq:0]install];
        [[mywebView.layoutUpdate heightEq:0] install];
        
        if([detailModel.uniteArticleType isEqualToString:@"1"]){
            [self showCover:detailModel.magazineModel];
        }else if([detailModel.uniteArticleType isEqualToString:@"2"]){
            [self showIntroduction:detailModel];
        }else if([detailModel.uniteArticleType isEqualToString:@"3"]){
            [self showAD:detailModel.magazineModel];
        }else{
            [self showActicle:detailModel];
        }
    }
}

-(void)showAD:(MagazineModel*)model{
    self.backgroundColor = UIColor.whiteColor;
    
    NSString* cover = model.cover;
    [imageView loadUrl:[Proto getFileUrlByObjectId:cover] placeholderImage:@"" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGFloat imageheight=self->imageViewCoverHeight;
        if (image) {
            self->imageView.image=image;
            imageheight=(image.size.width>0?(image.size.height/image.size.width*self.frame.size.width):self->imageViewCoverHeight);
            
        }
        [[self->imageView.layoutUpdate heightEq:imageheight ]install];
    }];
//    [[imageView.layoutUpdate heightEq:imageViewCoverHeight ]install];
    
}
   
-(void)showCover:(MagazineModel*)model{
    self.backgroundColor = UIColor.blackColor;

    NSString* cover = model.cover;
    [imageView loadUrl:[Proto getFileUrlByObjectId:cover] placeholderImage:@"" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGFloat imageheight=self->imageViewCoverHeight;
        if (image) {
            self->imageView.image=image;
            imageheight=(image.size.width>0?(image.size.height/image.size.width*self.frame.size.width):self->imageViewCoverHeight);
            
        }
        [[self->imageView.layoutUpdate heightEq:imageheight ]install];
    }];
    

    swipeView.hidden = NO;
}

-(void)showIntroduction:(DetailModel*)model{
    self.backgroundColor = UIColor.whiteColor;
    
    [[mywebView.layoutUpdate heightEq:1] install];
    [mywebView loadHTMLString:[NSString webHtmlString:model.content] baseURL:nil];
    
    [[imageView.layoutUpdate heightEq:0 ]install];
    
    calcWebViewHeightTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calcWebViewHeight:) userInfo:nil repeats:YES];
    
//    NSLog(@"html-%@",model.content);
}


-(void)showActicle:(DetailModel*)model{
    self.backgroundColor = UIColor.whiteColor;
    
    NSString* type = model.featuredMedia[@"type"];
    if([type isEqualToString:@"1"] ){
        //pic
        NSDictionary *codeDic = model.featuredMedia[@"code"];
        NSString *urlstr = codeDic[@"thumbnailUrl"];
        [imageView loadUrl:urlstr placeholderImage:@"" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                [[self->imageView.layoutUpdate heightEq:self->imageViewHeight ]install];
            }else{
                [[self->imageView.layoutUpdate heightEq:0 ]install];
            }
        }];
    }


    [titleView layoutRemoveAllConstraints];
    [[[[titleView.layoutMaker below:imageView offset:0] leftParent:edge]rightParent:-edge] install];
    
    titleLabel.text = model.title;
    subTitleLabel.text = model.subTitle;
    authorLabel.text = [NSString stringWithFormat:@"By %@ %@",model.author.firstName,model.author.lastName];
    
    
    [[mywebView.layoutUpdate heightEq:1] install];
    [mywebView loadHTMLString:[NSString webHtmlString:model.content] baseURL:nil];
    
    
    calcWebViewHeightTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calcWebViewHeight:) userInfo:nil repeats:YES];
//     NSLog(@"html-%@",model.content);
}


- (void)calcWebViewHeight:(NSTimer*)timer {
    //获取到webview的高度
    CGFloat webViewHeight1 = [[mywebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    CGFloat webViewHeight2 = [[mywebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGFloat webViewHeight3 = [[mywebView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
    
//    NSLog(@"webViewHeight1 == %f",webViewHeight1);
//    NSLog(@"webViewHeight2 == %f",webViewHeight2);
//    NSLog(@"webViewHeight3 == %f",webViewHeight3);
    
    [[mywebView.layoutUpdate heightEq:webViewHeight1]install];
    if(calcWebViewHeightTimes<100){
        calcWebViewHeightTimes++;
    }else{
        [calcWebViewHeightTimer invalidate];
        calcWebViewHeightTimer = nil;
    }
}


#pragma mark ---UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //禁止用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    //禁止长按弹出选择框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
//    [[webView.layoutUpdate heightEq:webViewHeight]install];
    
    NSLog(@"---------webViewHeight----%f",webViewHeight );
    NSLog(@"---------webViewDidFinishLoad-%@-%f",self,webViewHeight );
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"---------didFailLoadWithError--%@---%@",self,error);
    
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

- (void)dealloc{
    if(calcWebViewHeightTimer && [calcWebViewHeightTimer isValid]){
        [calcWebViewHeightTimer invalidate];
        calcWebViewHeightTimer = nil;
    }
}
@end
