//
//  PicDetailView.m
//  dentist
//
//  Created by Jacksun on 2018/10/17.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "PicDetailView.h"
#import "XHStarRateView.h"
#import "Article.h"
#import "YBImageBrowser.h"
#import "DentistImageBrowserToolBar.h"
#import "Proto.h"

@interface PicDetailView()<WKNavigationDelegate,UIScrollViewDelegate,UIWebViewDelegate>
{
    UIWebView *mywebView;
}
@end

@implementation PicDetailView
{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UIImageView *imageView;
    UIImageView *headerImg;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    WKWebView *contentWebView;
    UIView *view;
    UIScrollView *imageScroll;
    BOOL allowZoom;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 18;
    if(IS_IPHONE_P_X){
        edge=24;
    }
    allowZoom = YES;
    self.topView = [UIView new];
    self.topView.backgroundColor = rgb255(250, 251, 253);
    [self addSubview:self.topView];
    [[[[[self.topView.layoutMaker topParent:0] leftParent:0] rightParent:0] heightEq:40] install];
    typeLabel = [self.topView addLabel];
    typeLabel.font = [Fonts semiBold:12];
    [typeLabel textColorMain];
    [[[[[typeLabel.layoutMaker centerYParent:0] leftParent:edge] heightEq:24] rightParent:-90] install];
    
    dateLabel = [self.topView addLabel];
    [dateLabel textAlignRight];
    dateLabel.font = [Fonts regular:12];
    [dateLabel textColorAlternate];
    [[[[[dateLabel.layoutMaker centerYParent:0] rightParent:-edge] heightEq:24] widthEq:74] install];
    
    /****===the server back data is the movie or picture===****/
    
    imageView = self.addImageView;
    [imageView scaleFillAspect];
    [[[[[imageView.layoutMaker leftParent:0] rightParent:0] below:self.topView offset:0] heightEq:250] install];
    
    _moreButton = [self addButton];
    [_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[_moreButton.layoutMaker rightParent:-edge+5] below:imageView offset:edge] sizeEq:20 h:20] install];
    
    _markButton = [self addButton];
    [_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[_markButton.layoutMaker toLeftOf:_moreButton offset:-8] below:imageView offset:edge] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:20];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 0;
    [[[[titleLabel.layoutMaker leftParent:edge]  toLeftOf:_markButton offset:-edge-10] below:imageView offset:edge-5] install];
    [titleLabel.layoutMaker.height.equalTo(@24).priority(200) install];
    
    UILabel *lineLabel = [self lineLabel];
    [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] below:titleLabel offset:15] heightEq:1] install];
    
    view = [UIView new];
    [self addSubview:view];
    [[[[[view.layoutMaker leftParent:0] rightParent:0] below:lineLabel offset:0] heightEq:58] install];
    
    UILabel *byLabel = view.addLabel;
    byLabel.text = @"By";
    [[[[byLabel.layoutMaker sizeEq:30 h:58] leftParent:edge] topParent:0] install];
    
    headerImg = [UIImageView new];
    [view addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:32 h:32] toRightOf:byLabel offset:0] centerYParent:0] install];
    
    headerImg.layer.cornerRadius = 16;
    headerImg.layer.masksToBounds = YES;
    
    nameLabel = [view addLabel];
    nameLabel.font = [Fonts semiBold:12];
    [nameLabel textColorMain];
    [[[[[nameLabel.layoutMaker topParent:edge / 2 + 2] toRightOf:headerImg offset:8] rightParent:-edge] heightEq:16] install];
    
    addressLabel = [view addLabel];
    [addressLabel textAlignLeft];
    addressLabel.font = [Fonts regular:12];
    [addressLabel textColorAlternate];
    [[[[[addressLabel.layoutMaker topParent:edge / 2 + 18] toRightOf:headerImg offset:8] rightParent:-edge] heightEq:16] install];
    
    UILabel *lineLabel2 = [view lineLabel];
    [[[[[lineLabel2.layoutMaker leftParent:edge] rightParent:0] topParent:57] heightEq:1] install];
    
//    contentLabel = [self addLabel];
//    contentLabel.font = [Fonts regular:15];
//    [contentLabel textColorMain];
//    contentLabel.numberOfLines = 0;
//    [[[[contentLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:view offset:5] install];
    
//    contentWebView = [self addWebview];
//    contentWebView.navigationDelegate = self;
//    contentWebView.scrollView.delegate = self;
//    [[[[contentWebView.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:view offset:5] install];
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    [self addSubview:mywebView];
    [[[[mywebView.layoutMaker leftParent:10] rightParent:-10] below:view offset:5] install];
    
    UILabel *lineLabel3 = [self lineLabel];
    [[[[[lineLabel3.layoutMaker leftParent:0] rightParent:0] below:mywebView offset:25] heightEq:1] install];
    
    [self moreView];
    [self createStarView];
    
    return self;
}

- (void)moreView{
    
    UIView *moreView = [UIView new];
    [self addSubview:moreView];
    [[[[[[moreView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:202] below:mywebView offset:26] install];
    UILabel *conLabel = [moreView addLabel];
    conLabel.font = [Fonts regular:12];
    [conLabel textColorAlternate];
    conLabel.text = @"Gallery";
    [[[[[conLabel.layoutMaker leftParent:18] widthEq:100] topParent:0] heightEq:50] install];
    
    UILabel *picNumLab = [moreView addLabel];
    picNumLab.font = [Fonts regular:12];
    [picNumLab textColorAlternate];
    picNumLab.text = @"6 images";
    [[[[picNumLab.layoutMaker rightParent:-18] topParent:0] heightEq:50] install];
    
    imageScroll = [moreView addScrollView];
    [[[[[imageScroll.layoutMaker leftParent:0] rightParent:0] below:conLabel offset:0] heightEq:140] install];
    
    NSArray *imageArray = @[
                            @"slide-1",
                            @"slide-2",
                            @"slide-3",
                            @"slide-4",
                            @"slide-5"];
    
    for (int i = 0; i < imageArray.count; i++) {
        UIButton *imgBtn = [UIButton new];
        imgBtn.tag = 10+i;
        [imgBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.frame = CGRectMake(EDGE + (133 + 10) * i, 4, 133, 133);
        imgBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
        imgBtn.imageView.clipsToBounds=YES;
        [imageScroll addSubview:imgBtn];
    }
    
    imageScroll.contentSize = CGSizeMake(EDGE + (133 + 10) * imageArray.count, imageScroll.frame.size.height);

    
    UILabel *lineLabel4 = [self lineLabel];
    [[[[[lineLabel4.layoutMaker leftParent:0] rightParent:0] below:imageScroll offset:28] heightEq:1] install];
}

- (void)imgBtnClick:(UIButton *)btn
{
    [self showImageBrowser:btn.tag-10];
}

-(void)showImageBrowser:(NSInteger)index
{
    NSInteger tempindex;
    
    NSArray *dataArray = @[
                           @"https://www.dsodentist.com/assets/images/slide/slide-1.jpg",
                           @"https://www.dsodentist.com/assets/images/slide/slide-2.jpg",
                           @"https://www.dsodentist.com/assets/images/slide/slide-3.jpg",
                           @"https://www.dsodentist.com/assets/images/slide/slide-4.jpg",
                           @"https://www.dsodentist.com/assets/images/slide/slide-5.jpg"];
    if (index>0 && index <dataArray.count) {
        tempindex=index;
    }
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:urlStr];
        [browserDataArr addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    DentistImageBrowserToolBar *toolBar = [DentistImageBrowserToolBar new];
    toolBar.detailArray=@[@"Welcome",@"Reduce Plaque and Gingivitis",@"Today's Peer to Peer community...",@"Understanding the DSO Practice Model",@"All the support I need..."];
    browser.toolBars = @[toolBar];
    browser.sheetView = nil;
    [browser show];
}

- (void)createStarView
{
    UIView *starView = [UIView new];
    starView.backgroundColor = rgb255(248, 248, 248);
    [self addSubview:starView];
    [[[[[[starView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:100] below:imageScroll offset:26] install];
    
    _bgBtn = starView.addButton;
    [[[[[_bgBtn.layoutMaker leftParent:0] rightParent:0] sizeEq:SCREENWIDTH h:100] below:imageScroll offset:26] install];
    
    UILabel *finLabel = [starView addLabel];
    finLabel.font = [Fonts regular:12];
    [finLabel textColorAlternate];
    finLabel.textAlignment = NSTextAlignmentCenter;
    finLabel.text = @"Finished the content?";
    [[[[[finLabel.layoutMaker leftParent:18] rightParent:-18] topParent:15] heightEq:20] install];
    
    UILabel *reviewLabel = [starView addLabel];
    reviewLabel.font = [Fonts semiBold:12];
    [reviewLabel textColorMain];
    reviewLabel.textAlignment = NSTextAlignmentCenter;
    reviewLabel.text = @"Add your review";
    [[[[[reviewLabel.layoutMaker leftParent:18] rightParent:-18] below:finLabel offset:0] heightEq:20] install];
    
    XHStarRateView *star = [[XHStarRateView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 160)/2, 60, 160, 30)];
    star.isAnimation = NO;
    star.rateStyle = HalfStar;
    star.userInteractionEnabled = NO;
    star.tag = 1;
    [starView addSubview:star];
    
    UILabel *lineLabel4 = [starView lineLabel];
    [[[[[lineLabel4.layoutMaker leftParent:0] rightParent:0]
       topParent:99] heightEq:1] install];
    [starView.layoutMaker.bottom.equalTo(self.mas_bottom) install];
    
    
}

- (void)bind:(DetailModel *)bindInfo {
    typeLabel.text = [bindInfo.categoryName uppercaseString];
    dateLabel.text = [NSString timeWithTimeIntervalString:bindInfo.publishDate];
    NSString *urlstr;
    if (bindInfo.featuredMediaId) {
        urlstr=[Proto getFileUrlByObjectId:bindInfo.featuredMediaId];
    }
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
    [headerImg loadUrl:@"http://app800.cn/i/p.png" placeholderImage:@"user_img"];
    titleLabel.text = bindInfo.title;
    nameLabel.text = [NSString stringWithFormat:@"%@ %@",bindInfo.author.firstName,bindInfo.author.lastName];
    addressLabel.text = bindInfo.author.authorDetails;
    
    [mywebView loadHTMLString:[self htmlString:bindInfo.content] baseURL:nil];
    if (bindInfo.isBookmark) {
        [_markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
}

- (NSString *)htmlString:(NSString *)html
{
    //do some regular
//    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", SCREENWIDTH - 20, html];
    
    NSString *htmlString = @"<style>.first-big p:first-letter{float: left;font-size:1.9em;padding-right:5px;text-transform:uppercase;color:#4a4a4a;}p{width:100%;color:#4a4a4a;font-size:1em;}</style>";
    
    
    NSArray *array = [html componentsSeparatedByString:@"<p>"];
    for (int i = 0; i < [array count]; i++) {
        NSString *currentString = [array objectAtIndex:i];
        if(i==2){
            htmlString = [NSString stringWithFormat:@"%@<div class='first-big'><p>%@</div>",htmlString,currentString];
        }else if(i>2){
            htmlString = [NSString stringWithFormat:@"%@<p>%@",htmlString,currentString];
        }
    }
    
    return htmlString;
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if(!allowZoom){
        return nil;
    }else{
        return contentWebView.scrollView.subviews.firstObject;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    allowZoom = NO;
    [webView evaluateJavaScript:@"document.body.scrollWidth" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat ratio =  CGRectGetWidth(self->contentWebView.frame) /[result floatValue];
        
        [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
        [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
        [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"completionHandler:nil];
        [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
            NSLog(@"scrollHeight高度：%.2f",[result floatValue]);
            NSLog(@"scrollHeight计算高度：%.2f",[result floatValue]*ratio);
            CGFloat newHeight = [result floatValue]*ratio;
            [[self->contentWebView.layoutUpdate heightEq:newHeight] install];
            
        }];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [[mywebView.layoutUpdate heightEq:webViewHeight] install];
}

- (void)resetLayout {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
