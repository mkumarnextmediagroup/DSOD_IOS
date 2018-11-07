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
#import "UIButton+WebCache.h"

@interface PicDetailView()<WKNavigationDelegate,UIScrollViewDelegate,UIWebViewDelegate>
{
    
}
@end

@implementation PicDetailView
{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UIImageView *imageView;
    SBPlayer *sbPlayer;
    UIImageView *headerImg;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *byLabel;
    UIWebView *mywebView;
    UIView *view;
    UIView *imageScrollPView;
    UIScrollView *imageScroll;
    BOOL allowZoom;
    BOOL authorDSODentist;
    
    NSArray *imageArray;
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
    [[[[[dateLabel.layoutMaker centerYParent:0] rightParent:-edge] heightEq:24] widthEq:80] install];
    
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
    
    byLabel = view.addLabel;
    byLabel.font = [Fonts semiBold:18];
    byLabel.text = @"By";
    [[[[byLabel.layoutMaker sizeEq:30 h:58] leftParent:edge] topParent:0] install];
    
    headerImg = [UIImageView new];
    [view addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:110 h:22] toRightOf:byLabel offset:0] centerYParent:0] install];
    headerImg.layer.masksToBounds = YES;
    
    nameLabel = [view addLabel];
    nameLabel.font = [Fonts semiBold:12];
    [nameLabel textColorMain];
    [[[[[nameLabel.layoutMaker topParent:edge / 2 + 2] leftParent:edge] rightParent:-edge] heightEq:16] install];
    
    addressLabel = [view addLabel];
    [addressLabel textAlignLeft];
    addressLabel.font = [Fonts regular:12];
    [addressLabel textColorAlternate];
    [[[[[addressLabel.layoutMaker topParent:edge / 2 + 18] leftParent:edge] rightParent:-edge] heightEq:16] install];
    
    UILabel *lineLabel2 = [view lineLabel];
    [[[[[lineLabel2.layoutMaker leftParent:edge] rightParent:0] topParent:57] heightEq:1] install];
    
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    [self addSubview:mywebView];
    [[[[mywebView.layoutMaker leftParent:edge] rightParent:-edge] below:view offset:5] install];
    
    [self moreView];
    [self createStarView];

    
    return self;
}

- (void)moreView{
    
    imageScrollPView = [UIView new];
    [self addSubview:imageScrollPView];
    [[[[[[imageScrollPView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:202] below:mywebView offset:26] install];
    
    UILabel *lineLabelTop = [imageScrollPView lineLabel];
    [[[[[lineLabelTop.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:1] install];

    [self setImageScrollData:nil];
}

-(void)setImageScrollData:(NSArray*)data{
    imageArray = data;
    if(data==nil||data.count==0){
        imageScrollPView.hidden = YES;
        [[imageScrollPView.layoutUpdate heightEq:0]install];
        return;
    }
    
    UILabel *conLabel = [imageScrollPView addLabel];

    conLabel.font = [Fonts regular:12];
    [conLabel textColorAlternate];
    conLabel.text = @"Gallery";
    [[[[[conLabel.layoutMaker leftParent:18] widthEq:100] topParent:0] heightEq:50] install];
    
    UILabel *picNumLab = [imageScrollPView addLabel];
    picNumLab.font = [Fonts regular:12];
    [picNumLab textColorAlternate];

    picNumLab.text = [NSString stringWithFormat:@"%lu images",imageArray.count];

    [[[[picNumLab.layoutMaker rightParent:-18] topParent:0] heightEq:50] install];
    
    imageScroll = [imageScrollPView addScrollView];
    [[[[[imageScroll.layoutMaker leftParent:0] rightParent:0] below:conLabel offset:0] heightEq:140] install];
    
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imgBtn = [UIImageView new];
        imgBtn.tag = 10+i;
        
        [imgBtn loadUrl:((NSDictionary*)imageArray[i])[@"thumbnailUrl"] placeholderImage:@""];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBtnClick:)];
        [imgBtn addGestureRecognizer:singleTap];

        imgBtn.frame = CGRectMake(EDGE + (133 + 10) * i, 4, 133, 133);
        imgBtn.contentMode=UIViewContentModeScaleAspectFill;
        imgBtn.clipsToBounds=YES;
        imgBtn.userInteractionEnabled = YES;
        [imageScroll addSubview:imgBtn];
        
    }
    
    imageScroll.contentSize = CGSizeMake(EDGE + (133 + 10) * imageArray.count, imageScroll.frame.size.height);

    
    imageScrollPView.hidden = NO;
    [[imageScrollPView.layoutUpdate heightEq:202]install];

}

- (void)imgBtnClick:(UITapGestureRecognizer *)tap
{
    [self showImageBrowser: ((UIImageView*) tap.view).tag-10];
}

-(void)showImageBrowser:(NSInteger)index
{
    NSInteger tempindex;
    NSMutableArray *browserDataArr = [NSMutableArray array];
    
    if (index>0 && index <imageArray.count) {
        tempindex=index;
    }
    
    for (int i=0;i<imageArray.count; i++) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:((NSDictionary*)imageArray[i])[@"originalUrl"]];
        [browserDataArr addObject:data];
    }
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    DentistImageBrowserToolBar *toolBar = [DentistImageBrowserToolBar new];
//    toolBar.detailArray=@[@"Welcome",@"Reduce Plaque and Gingivitis",@"Today's Peer to Peer community...",@"Understanding the DSO Practice Model",@"All the support I need..."];
    browser.toolBars = @[toolBar];
    browser.sheetView = nil;
    [browser show];
}

- (void)createStarView
{
    UIView *starView = [UIView new];
    starView.backgroundColor = rgb255(248, 248, 248);
    [self addSubview:starView];

    [[[[[[starView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:100] below:imageScrollPView offset:26] install];
    
    UILabel *lineLabeltop = [starView lineLabel];
    [[[[[lineLabeltop.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:1] install];
    
    _bgBtn = starView.addButton;
    [[[[[_bgBtn.layoutMaker leftParent:0] rightParent:0] sizeEq:SCREENWIDTH h:100] topParent:0] install];

    
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
    
    
    
    
    NSString* type = bindInfo.featuredMedia[@"type"];
    if([type isEqualToString:@"1"] ){
        //pic
        NSDictionary *codeDic = bindInfo.featuredMedia[@"code"];
        NSString *urlstr = codeDic[@"thumbnailUrl"];
        [imageView loadUrl:urlstr placeholderImage:@""];
    }else if([type isEqualToString:@"2"] ){
        //video
        //初始化播放器
        if (!sbPlayer) {
            NSString *urlstr = bindInfo.featuredMedia[@"code"];
            sbPlayer = [[SBPlayer alloc] initWithUrl:[NSURL URLWithString:urlstr]];
            sbPlayer.addView = self;
            //set the movie background color
            sbPlayer.backgroundColor = [UIColor blackColor];
            [self addSubview:sbPlayer];
            [[[[[sbPlayer.layoutMaker leftParent:0] rightParent:0] below:self.topView offset:0] heightEq:250] install];
        }
    }
    

    
    titleLabel.text = bindInfo.title;
    [headerImg setImageName:@"author_dsodentist"];
    
    [mywebView loadHTMLString:[self htmlString:bindInfo.content] baseURL:nil];
    
    if(authorDSODentist){
        byLabel.hidden = NO;
        headerImg.hidden = NO;
        nameLabel.hidden = YES;
        addressLabel.hidden = YES;
    }else{
        byLabel.hidden = YES;
        headerImg.hidden = YES;
        nameLabel.hidden = NO;
        addressLabel.hidden = NO;
        nameLabel.text = [NSString stringWithFormat:@"By %@ %@",bindInfo.author.firstName,bindInfo.author.lastName];
        addressLabel.text = bindInfo.author.authorDetails;
    }
    
    if (bindInfo.isBookmark) {
        [_markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
    
    //处理图片
    [self setImageScrollData:bindInfo.photoUrls];

}

- (NSString *)htmlString:(NSString *)html
{
    //do some regular
//    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", SCREENWIDTH - 20, html];
    
    NSString *htmlString = @"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style>body{padding:0px;margin:0px;}.first-big p:first-letter{float: left;font-size:1.9em;padding-right:5px;text-transform:uppercase;color:#4a4a4a;}p{width:100%;color:#4a4a4a;font-size:1em;}</style>";
    
    htmlString = [NSString stringWithFormat:@"%@%@%@%@%@",htmlString,
                  @"<style type='text/css'>",
                  @"blockquote{color:#4a4a4a;font-size:1.5em;font-weight:bold;margin: 0px 10px 0px 30px;position:relative;line-height:110%;text-indent:0px}",
                  @"blockquote:before{color:#4a4a4a;content:'“';font-size:2em;position:absolute;left:-30px;top:10px;line-height:.1em}",
                  //@"blockquote:after{color:#4a4a4a;content:'”';font-size:5em;position:absolute;right:15px;bottom:0;line-height:.1em}",
                  @"</style>"
                  ];
    

//
//    @"blockquote{color:#4a4a4a;font-size:1.5em;font-weight:bold;margin: 0px 10px 0px 10px;position:relative;line-height:110%;text-indent:20px}",
//    @"blockquote:before{color:#4a4a4a;content:'“';font-size:2em;position:absolute;left:-30px;top:15px;line-height:.1em}",
//

    
    html = [html stringByReplacingOccurrencesOfString :@"pre" withString:@"blockquote"];
    
    BOOL isFirst = YES;
    NSArray *array = [html componentsSeparatedByString:@"<p>"];
    for (int i = 0; i < [array count]; i++) {
        NSString *currentString = [array objectAtIndex:i];
        if(i==1){
            authorDSODentist = [currentString rangeOfString:@"By DSODentist"].location !=NSNotFound;
        }else if(i>=2){
            if([currentString rangeOfString:@"<iframe"].location !=NSNotFound){
                continue;
            }
            if(isFirst){
                 htmlString = [NSString stringWithFormat:@"%@<div class='first-big'><p>%@</div>",htmlString,currentString];
                 isFirst = NO;
            }else{
                 htmlString = [NSString stringWithFormat:@"%@<p>%@",htmlString,currentString];
            }
        }
    }
    
    return htmlString;
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if(!allowZoom){
        return nil;
    }else{
        return mywebView.scrollView.subviews.firstObject;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    allowZoom = NO;
    [webView evaluateJavaScript:@"document.body.scrollWidth" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat ratio =  CGRectGetWidth(self->mywebView.frame) /[result floatValue];
        
        [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
        [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
        [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"completionHandler:nil];
        [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
            NSLog(@"scrollHeight高度：%.2f",[result floatValue]);
            NSLog(@"scrollHeight计算高度：%.2f",[result floatValue]*ratio);
            CGFloat newHeight = [result floatValue]*ratio;
            [[self->mywebView.layoutUpdate heightEq:newHeight] install];
            
        }];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //禁止用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    //禁止长按弹出选择框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
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
