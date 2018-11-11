//
//  PlayerView.m
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//  由PicDtailView代替，本类不在更新  wanglibo 2018.11.11

#import "PlayerView.h"
#import "Article.h"
#import "XHStarRateView.h"
#import "Proto.h"

@interface PlayerView()<WKNavigationDelegate,UIScrollViewDelegate,UIWebViewDelegate>

@end

@implementation PlayerView {
	UILabel *typeLabel;
	UILabel *dateLabel;
	UIImageView *imageView;
	UIImageView *headerImg;
	UILabel *titleLabel;
	UILabel *nameLabel;
	UILabel *addressLabel;
    UILabel *byLabel;
    UILabel *contentLabel;
    UIWebView *mywebView;
	UIView *view;
    UILabel *contentLabel2;
    
    BOOL authorDSODentist;
    BOOL allowZoom;
}

- (instancetype)init {
	self = [super init];

    NSInteger edge = 18;
    if(IS_IPHONE_P_X){
        edge=24;
    }

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

	_greeBtn = [self addButton];
	[_greeBtn.titleLabel setFont:[Fonts regular:12]];
	_greeBtn.titleLabel.textColor = [UIColor whiteColor];
	_greeBtn.backgroundColor = rgb255(111, 201, 211);
	[[[[[_greeBtn.layoutMaker leftParent:0] rightParent:0] below:imageView offset:0] heightEq:62] install];

	_moreButton = [self addButton];
	[_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
	[[[[_moreButton.layoutMaker rightParent:-edge+5] below:_greeBtn offset:edge] sizeEq:20 h:20] install];

	_markButton = [self addButton];
	[_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
	[[[[_markButton.layoutMaker toLeftOf:_moreButton offset:-8] below:_greeBtn offset:edge] sizeEq:20 h:20] install];

	titleLabel = [self addLabel];
	titleLabel.font = [Fonts semiBold:20];
	[titleLabel textColorMain];
	titleLabel.numberOfLines = 0;
	[[[[titleLabel.layoutMaker leftParent:edge]  toLeftOf:_markButton offset:-edge-10] below:_greeBtn offset:edge-5] install];
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
	[[[[[nameLabel.layoutMaker topParent:edge / 2 + 2] toRightOf:headerImg offset:8] rightParent:-edge] heightEq:16] install];

	addressLabel = [view addLabel];
	[addressLabel textAlignLeft];
	addressLabel.font = [Fonts regular:12];
	[addressLabel textColorAlternate];
	[[[[[addressLabel.layoutMaker topParent:edge / 2 + 18] toRightOf:headerImg offset:8] rightParent:-edge] heightEq:16] install];

	UILabel *lineLabel2 = [view lineLabel];
	[[[[[lineLabel2.layoutMaker leftParent:edge] rightParent:0] topParent:57] heightEq:1] install];
    
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    [self addSubview:mywebView];
    [[[[mywebView.layoutMaker leftParent:edge] rightParent:-edge] below:view offset:5] install];

//    contentLabel = [self addLabel];
//    contentLabel.font = [Fonts regular:15];
//    [contentLabel textColorMain];
//    contentLabel.numberOfLines = 0;
//    [[[[[contentLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] heightEq:30] below:view offset:5] install];
//    [[[[contentLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:view offset:5] install];


	UIImageView *imgCon = [UIImageView new];
    imgCon.image = [UIImage imageNamed:@"content_bg"];
	[self addSubview:imgCon];
	[[[[[imgCon.layoutMaker sizeEq:SCREENWIDTH h:298] leftParent:0] rightParent:0] below:mywebView offset:25] install];

    contentLabel2 = [self addLabel];
    contentLabel2.font = [Fonts regular:15];
    [contentLabel2 textColorMain];
    contentLabel2.numberOfLines = 0;
    //    [[[[[contentLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] heightEq:30] below:view offset:5] install];
    [[[[contentLabel2.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:imgCon offset:15] install];
    
    UILabel *lineLabel3 = [self lineLabel];
    [[[[[lineLabel3.layoutMaker leftParent:0] rightParent:0] below:contentLabel2 offset:25] heightEq:1] install];
    
//    [lineLabel3.layoutMaker.bottom.equalTo(self.mas_bottom) install];
    
    [self moreView];
    [self createStarView];
    
	return self;
}

- (void)moreView{
    
    UIView *moreView = [UIView new];
    [self addSubview:moreView];
    [[[[[[moreView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:120] below:contentLabel2 offset:26] install];
    UILabel *conLabel = [moreView addLabel];
    conLabel.font = [Fonts regular:12];
    [conLabel textColorAlternate];
    conLabel.text = @"Want more content from GSK?";
    [[[[[conLabel.layoutMaker leftParent:18] rightParent:-18] topParent:0] heightEq:50] install];
    [conLabel textAlignCenter];
    
    self.gskBtn = [moreView addButton];
    self.gskBtn.backgroundColor = rgb255(111, 201, 211);
    [self.gskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.gskBtn setTitle:@"Access GSK Science" forState:UIControlStateNormal];
    self.gskBtn.titleLabel.font = [Fonts regular:14];
    [[[[[self.gskBtn.layoutMaker leftParent:18] rightParent:-18] below:conLabel offset:0] heightEq:36] install];
    
    UILabel *lineLabel4 = [self lineLabel];
    [[[[[lineLabel4.layoutMaker leftParent:0] rightParent:0] below:self.gskBtn offset:28] heightEq:1] install];
}

- (void)createStarView
{
    UIView *starView = [UIView new];
    starView.backgroundColor = rgb255(248, 248, 248);
    [self addSubview:starView];
    [[[[[[starView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:100] below:self.gskBtn offset:26] install];
    
    _bgBtn = starView.addButton;
    [[[[[_bgBtn.layoutMaker leftParent:0] rightParent:0] sizeEq:SCREENWIDTH h:100] below:self.gskBtn offset:26] install];
    
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
    star.userInteractionEnabled = NO;
    star.rateStyle = HalfStar;
    star.tag = 1;
    [starView addSubview:star];
    
    UILabel *lineLabel4 = [starView lineLabel];
    [[[[[lineLabel4.layoutMaker leftParent:0] rightParent:0]
       topParent:99] heightEq:1] install];
    [starView.layoutMaker.bottom.equalTo(self.mas_bottom) install];


}

-(void)bind:(DetailModel *)bindInfo {
    typeLabel.text = [bindInfo.categoryName uppercaseString];
    dateLabel.text = [NSString timeWithTimeIntervalString:bindInfo.publishDate];
    NSString *urlstr;
    if (bindInfo.videos.count > 0) {
        urlstr=[Proto getFileUrlByObjectId:bindInfo.videos[0]];
    }
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
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
    
    //初始化播放器
    if (!self.sbPlayer) {
        self.sbPlayer = [[SBPlayer alloc] initWithUrl:[NSURL URLWithString:urlstr]];
        self.sbPlayer.addView = self;
        //set the movie background color
        self.sbPlayer.backgroundColor = [UIColor blackColor];
        [self addSubview:self.sbPlayer];
        [[[[[self.sbPlayer.layoutMaker leftParent:0] rightParent:0] below:self.topView offset:0] heightEq:250] install];
    }
    
	titleLabel.text = bindInfo.title;
//    [_greeBtn setTitle:bindInfo.gskString forState:UIControlStateNormal];
    [_greeBtn setImage:[UIImage imageNamed:@"gskIcon"] forState:UIControlStateNormal];
    nameLabel.text = [NSString stringWithFormat:@"%@ %@",bindInfo.author.firstName,bindInfo.author.lastName];
    addressLabel.text = bindInfo.author.authorDetails;
    contentLabel.text = bindInfo.content;
//    [contentWebView loadHTMLString:bindInfo.content baseURL:nil];
//    contentLabel2.text = bindInfo.subContent;
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
    
    NSArray *array = [html componentsSeparatedByString:@"<p>"];
    for (int i = 0; i < [array count]; i++) {
        NSString *currentString = [array objectAtIndex:i];
        if(i==1){
            authorDSODentist = [currentString rangeOfString:@"By DSODentist"].location !=NSNotFound;
        }if(i==2){
            htmlString = [NSString stringWithFormat:@"%@<div class='first-big'><p>%@</div>",htmlString,currentString];
        }else if(i>2){
            htmlString = [NSString stringWithFormat:@"%@<p>%@",htmlString,currentString];
        }
    }
    
    return htmlString;
    
}

- (void)resetLayout {
    CGSize size = [contentLabel sizeThatFits:CGSizeMake(290, 1000)];
    CGSize size2 = [contentLabel2 sizeThatFits:CGSizeMake(290, 1000)];
    [[contentLabel.layoutUpdate heightEq:size.height] install];
    [[contentLabel2.layoutUpdate heightEq:size2.height] install];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
