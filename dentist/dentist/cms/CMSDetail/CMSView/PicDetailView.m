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
#import "CMSDetailViewController.h"
#import "GDataXMLNode.h"
#import "GSKViewController.h"

@interface PicDetailView()<WKNavigationDelegate,UIScrollViewDelegate,UIWebViewDelegate,
UITableViewDelegate,UITableViewDataSource>
{
    
}
@end

@implementation PicDetailView
{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UIImageView *imageView;
    UIImageView *thumbImageView;
    UIWebView *vedioWebView;
    UIImageView *headerImg;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *byLabel;
    UIImageView *dsodImg;
    UIWebView *mywebView;
    UITableView *relativeTopicTableView;
    UITableView *referencesTableView;
    UIView *view;
    UIView *imageScrollPView;
    UIScrollView *imageScroll;
    UIView *sponsorView;
    UILabel *sponsorLabel;
    
    BOOL allowZoom;
    
    NSArray *relativeTopicArray;
    NSArray *referencesArray;
    BOOL referencesMoreMode;
    NSArray *imageArray;
    
    NSString *videoHtmlString;
    
    NSInteger edge;
    
    NSTimer *calcWebViewHeightTimer;
    int calcWebViewHeightTimes;
}

- (instancetype)init {
    self = [super init];
    
    edge = 18;
//    if(IS_IPHONE_P_X){
//        edge=24;
//    }
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
    imageView.clipsToBounds = YES;
    [[[[[imageView.layoutMaker leftParent:0] rightParent:0] below:self.topView offset:0] heightEq:SCREENWIDTH*2/3] install];
    
    
    thumbImageView = imageView.addImageView;
    [[[[thumbImageView.layoutMaker leftParent:edge] bottomParent:-edge] sizeEq:28 h:28] install];
    
    
    CGFloat sponstorimgh=((50.0/375.0)*SCREENWIDTH);
    _sponsorImageBtn = [self addButton];
    [[[[[_sponsorImageBtn.layoutMaker leftParent:0] rightParent:0] below:imageView offset:0] heightEq:sponstorimgh] install];
    [_sponsorImageBtn setBackgroundImage:[UIImage imageNamed:@"sponsor_gsk"] forState:UIControlStateNormal];
    
    _moreButton = [self addButton];
    [_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[_moreButton.layoutMaker rightParent:0] below:_sponsorImageBtn offset:0] sizeEq:48 h:48] install];
    [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    
    _markButton = [self addButton];
    [_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[_markButton.layoutMaker toLeftOf:_moreButton offset:0] below:_sponsorImageBtn offset:0] sizeEq:48 h:48] install];
    [_markButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:20];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 0;
    [[[[titleLabel.layoutMaker leftParent:edge]  toLeftOf:_markButton offset:15] below:_sponsorImageBtn offset:10] install];
    [titleLabel.layoutMaker.height.equalTo(@24).priority(200) install];
    
    UILabel *lineLabel = [self lineLabel];
    [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] below:titleLabel offset:15] heightEq:1] install];
    
    view = [UIView new];
    [self addSubview:view];
    [[[[[view.layoutMaker leftParent:0] rightParent:0] below:lineLabel offset:0] heightEq:58] install];
    
    byLabel = view.addLabel;
    byLabel.font = [Fonts semiBold:20];
    byLabel.text = @"By";
    [[[[byLabel.layoutMaker sizeEq:30 h:58] leftParent:edge] topParent:0] install];
    
    dsodImg = [UIImageView new];
    [view addSubview:dsodImg];
    [[[[dsodImg.layoutMaker sizeEq:110 h:22] toRightOf:byLabel offset:0] centerYParent:0] install];
    dsodImg.layer.masksToBounds = YES;
    dsodImg.image = [UIImage imageNamed:@""];
    [dsodImg setImageName:@"author_dsodentist"];
    
    
    headerImg = [UIImageView new];
    [view addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:32 h:32] leftParent:edge] centerYParent:0] install];
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
    
    
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    mywebView.backgroundColor = UIColor.redColor;
    [self addSubview:mywebView];
    [[[[[mywebView.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:view offset:0] install];

    
    relativeTopicTableView = [UITableView new];
    relativeTopicTableView.dataSource = self;
    relativeTopicTableView.delegate = self;
    relativeTopicTableView.estimatedRowHeight = 10;
    relativeTopicTableView.rowHeight=UITableViewAutomaticDimension;
    relativeTopicTableView.scrollEnabled = NO;
    relativeTopicTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    relativeTopicTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self addSubview:relativeTopicTableView];
    [[[[[relativeTopicTableView.layoutMaker leftParent:edge] rightParent:-edge] heightEq:0] below:mywebView offset:0] install];
    
    
    referencesTableView = [UITableView new];
    referencesTableView.dataSource = self;
    referencesTableView.delegate = self;
    referencesTableView.estimatedRowHeight = 10;
    referencesTableView.rowHeight=UITableViewAutomaticDimension;
    referencesTableView.scrollEnabled = NO;
    referencesTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    referencesTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self addSubview:referencesTableView];
    [[[[[referencesTableView.layoutMaker leftParent:edge] rightParent:-edge] heightEq:0] below:relativeTopicTableView offset:0] install];
    
    
    [self createImageScrollView];
    [self createSsponsorView];
    [self createStarView];

    
//    relativeTopicTableView.backgroundColor = UIColor.blueColor;
//    referencesTableView.backgroundColor = UIColor.greenColor;
//    imageScrollPView.backgroundColor = UIColor.greenColor;
//    sponsorView.backgroundColor = UIColor.orangeColor;
    
    return self;
}


- (void)createImageScrollView{
    
    imageScrollPView = [UIView new];
    [self addSubview:imageScrollPView];
    [[[[[imageScrollPView.layoutMaker leftParent:0] rightParent:0] heightEq:202] below:referencesTableView offset:0] install];
    
    UILabel *lineLabelTop = [imageScrollPView lineLabel];
    [[[[[lineLabelTop.layoutMaker leftParent:0] rightParent:0] topParent:26] heightEq:1] install];

    [self setImageScrollData:nil];
}

- (void)createSsponsorView{
    
    sponsorView = [UIView new];
    [self addSubview:sponsorView];
    sponsorView.clipsToBounds = YES;
    [[[[sponsorView.layoutMaker leftParent:0] rightParent:0] below:imageScrollPView offset:0] install];
    
    UILabel *lineLabelTop = [sponsorView lineLabel];
    [[[[[lineLabelTop.layoutMaker leftParent:0] rightParent:0] topParent:25] heightEq:1] install];
    
    sponsorLabel = [sponsorView addLabel];
    sponsorLabel.font = [Fonts regular:12];
    [sponsorLabel textColorAlternate];
    sponsorLabel.text = @"Want more content from GSK?";
    [[[[[sponsorLabel.layoutMaker leftParent:18] rightParent:-18] below:lineLabelTop offset:0] heightEq:50] install];
    [sponsorLabel textAlignCenter];
    
    self.sponsorBtn = [sponsorView addButton];
    self.sponsorBtn.backgroundColor = rgb255(111, 201, 211);
    [self.sponsorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sponsorBtn setTitle:@"Access GSK Science" forState:UIControlStateNormal];
    self.sponsorBtn.titleLabel.font = [Fonts regular:14];
    [[[[[self.sponsorBtn.layoutMaker leftParent:18] rightParent:-18] below:sponsorLabel offset:0] heightEq:36] install];
    
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
    [browser show];
}

- (void)createStarView
{
    UIView *starView = [UIView new];
    starView.backgroundColor = rgb255(248, 248, 248);
    [self addSubview:starView];

    [[[[[[starView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:100] below:sponsorView offset:15] install];
    
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

- (void)showRelativeTopic:(NSArray*)data{
    
   if(data && data.count>0){
        int height = 40;
        for(int i = 0;i< data.count;i++){
            CGSize titleSize = [data[i][@"title"] boundingRectWithSize:CGSizeMake(SCREENWIDTH-edge*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            height += titleSize.height + 10;//padding：10
        }
        [[relativeTopicTableView.layoutUpdate heightEq:height]install];
        
        relativeTopicArray = data;
        [relativeTopicTableView reloadData];
    }
}

- (void)showReferences:(NSArray*)data{
    referencesArray = data;
    if(referencesArray && referencesArray.count>0){
        int height = 40;//header
        long showCount = referencesArray.count;
        
        if(referencesArray.count>5){
            height += referencesArray.count>5?50:0;//footer
            showCount = referencesMoreMode ? referencesArray.count : 5;
        }
        
        for(int i = 0;i< showCount;i++){
            CGSize titleSize = [referencesArray[i] boundingRectWithSize:CGSizeMake(SCREENWIDTH-edge*2 - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[Fonts regular:16]} context:nil].size; //numberlabel:40
            height += titleSize.height + 10;//padding：10
        }
        [[referencesTableView.layoutUpdate heightEq:height]install];
        [referencesTableView reloadData];
    }
}

- (void)bind:(DetailModel *)bindInfo {
    typeLabel.text = [bindInfo.categoryName uppercaseString];
    dateLabel.text = [NSDate USDateShortFormatWithStringTimestamp:bindInfo.publishDate];
    
    NSString* type = bindInfo.featuredMedia[@"type"];
    if([type isEqualToString:@"1"] ){
        //pic
        NSDictionary *codeDic = bindInfo.featuredMedia[@"code"];
        NSString *urlstr = codeDic[@"thumbnailUrl"];
        [imageView loadUrl:urlstr placeholderImage:@""];
    }else if([type isEqualToString:@"2"] ){
        //这个判断不知道干啥的 因为服务器就没返回过2
    }
    NSDictionary *thumbImagInfo = @{@"VIDEOS":@"Video",
                                    @"PODCASTS":@"Podcast",
                                    @"INTERVIEWS":@"Interview",
                                    @"TECH GUIDES":@"TechGuide",
                                    @"ANIMATIONS":@"Animation",
                                    @"TIP SHEETS":@"TipSheet",
                                    @"ARTICLES":@"Article"
                                    };
    if (thumbImagInfo[[bindInfo.contentTypeName uppercaseString]]) {
        [thumbImageView setImage:[UIImage imageNamed:thumbImagInfo[[bindInfo.contentTypeName uppercaseString]]]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
    
    

    NSDictionary *sponsorInfo = @{@"260":@{@"name":@"Align" ,@"fullName":@"Align"         ,@"imgName":@"sponsor_align"},
                                  @"259":@{@"name":@"Nobel" ,@"fullName":@"Nobel Biocare" ,@"imgName":@"sponsor_nobel"},
                                  @"197":@{@"name":@"GSK"   ,@"fullName":@"GSK"           ,@"imgName":@"sponsor_gsk"}};
    
    if (sponsorInfo[bindInfo.sponsorId]) {
        [_sponsorImageBtn setBackgroundImage:[UIImage imageNamed:sponsorInfo[bindInfo.sponsorId][@"imgName"]] forState:UIControlStateNormal];
        sponsorLabel.text = [NSString stringWithFormat:@"Want more content from %@?" , sponsorInfo[bindInfo.sponsorId][@"name"]];
        [self.sponsorBtn setTitle:[NSString stringWithFormat:@"Access %@ Resources" ,sponsorInfo[bindInfo.sponsorId][@"fullName"]] forState:UIControlStateNormal];
        
        CGFloat sponstorimgh=((50.0/375.0)*SCREENWIDTH);
        [[_sponsorImageBtn.layoutUpdate heightEq:sponstorimgh] install];
        [[sponsorView.layoutUpdate heightEq:125] install];
    }else{
        [[_sponsorImageBtn.layoutUpdate heightEq:0] install];
        [[sponsorView.layoutUpdate heightEq:0] install];
    }

    
    titleLabel.text = bindInfo.title;
    
    
    if([bindInfo.author.firstName isEqualToString:@"DSODentist"]){
        byLabel.hidden = NO;
        dsodImg.hidden = NO;
        headerImg.hidden = YES;
        nameLabel.hidden = YES;
        addressLabel.hidden = YES;
    }else{
        byLabel.hidden = YES;
        dsodImg.hidden = YES;
        headerImg.hidden = NO;
        nameLabel.hidden = NO;
        addressLabel.hidden = NO;
        nameLabel.text = [NSString stringWithFormat:@"By %@ %@",bindInfo.author.firstName,bindInfo.author.lastName];
        addressLabel.text = bindInfo.author.authorDetails;
        
        [headerImg loadUrl:bindInfo.authorPhotoUrl placeholderImage:@"user_img"];
    }
    
    if (bindInfo.isBookmark) {
        [_markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
    
    [[mywebView.layoutUpdate heightEq:1] install];
    [mywebView loadHTMLString:[self htmlString:bindInfo.content] baseURL:nil];
    
    
    [self showVideo];
   
    [self showReferences:bindInfo.references];
    
    [self showRelativeTopic:bindInfo.relativeTopicList];
    
    [self setImageScrollData:bindInfo.photoUrls];
    
    
    if(calcWebViewHeightTimer){
        [calcWebViewHeightTimer invalidate];
        calcWebViewHeightTimer = nil;
    }
    calcWebViewHeightTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calcWebViewHeight:) userInfo:nil repeats:YES];

}

-(void)showVideo{
    if(videoHtmlString){
        NSRange iframeStart = [videoHtmlString rangeOfString:@"<iframe"];
        NSRange iframeEnd = [videoHtmlString rangeOfString:@"</iframe>"];
        
         if(iframeStart.location != NSNotFound && iframeEnd.location != NSNotFound){
            if (!vedioWebView) {
                vedioWebView = [UIWebView new];
                vedioWebView.scrollView.scrollEnabled = NO;
                [self addSubview:vedioWebView];
                [[[[[vedioWebView.layoutMaker leftParent:0] rightParent:0] below:self.topView offset:0] heightEq:SCREENWIDTH*2/3] install];
            }
            
            NSString *htmlString = videoHtmlString;
            htmlString = [htmlString substringWithRange:NSMakeRange(iframeStart.location,iframeEnd.location+iframeEnd.length - iframeStart.location)];
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"src=\"//" withString:@"src=\"https://"];
            htmlString = [NSString stringWithFormat:@"%@%@%@%@%@",
                  @"<style type=\"text/css\">",
                  @"body{padding:0px;margin:0px;background:#fff;font-family}",
                  @"iframe{border: 0 none;}",
                  @"</style>",
                  htmlString
                  ];
            [vedioWebView loadHTMLString:htmlString baseURL:nil];
         }
    }
}

- (NSString *)htmlString:(NSString *)html{
    NSString *htmlString = [NSString stringWithFormat:@"%@%@%@%@%@ %@%@%@%@%@ %@%@%@",
                            @"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'>",
                            @"<style type=\"text/css\">",
                            @"body{padding:0px;margin:0px;background:#fff;font-family:SFUIText-Regular;font-size:0.9em;color:#4a4a4a}",
                            @"p{margin: 10px auto;padding-left:18px;padding-right:18px}",
                            @"h1,h2,h3,h4,h5,h6{font-size:1.1em;padding-left:18px;padding-right:18px}",
                            @"ol,ul{background:#fff;margin-left:18px;margin-right:18px;padding-left:18px;}",
                            @"em{font-style:normal}",
                            @".first-big p:first-letter{float: left;font-size:2.8em;margin-top:-6px;margin-bottom:-18px;margin-right:5px;text-transform:uppercase;color:#879aa8;}",
                            @"blockquote{color:#4a4a4a;font-size:1.1em;font-weight:bold;margin: 20px 50px 10px 50px;position:relative;line-height:110%;text-indent:0px；background:#f00}",
                            @"blockquote:before{color:#4a4a4a;font-family:PingFangTC-Regular;content:'“';font-size:1.6em;position:absolute;left:-20px;top:15px;line-height:.1em}",
                            //@"blockquote:after{color:#4a4a4a;content:'”';font-size:5em;position:absolute;right:15px;bottom:0;line-height:.1em}"
                            @"figure{ margin:0 auto; background:#fff; }",
                            @"figure img{width:100%;height:''} img{width:100%;height:auto}",
                            @"</style>"
                            ];

    
    html = [html stringByReplacingOccurrencesOfString :@"<pre>" withString:@"<blockquote>"];
    html = [html stringByReplacingOccurrencesOfString :@"</pre>" withString:@"</blockquote>"];
    html = [html stringByReplacingOccurrencesOfString :@"<p>&nbsp;</p>" withString:@""];
//    html = [self htmlRemoveReferences:html];
    
    BOOL isFirst = YES;
    videoHtmlString = nil;
    NSArray *array = [html componentsSeparatedByString:@"<p>"];
    for (int i = 0; i < [array count]; i++) {
        NSString *currentString = [array objectAtIndex:i];
        if([currentString rangeOfString:@"<iframe"].location !=NSNotFound){
            videoHtmlString = currentString;
            continue;
        }
        if(i>0){
            if(isFirst){
                 //错误格式兼容<strong> </strong>厉害了中间还不是空格
//                 htmlString = [htmlString stringByReplacingOccurrencesOfString :@"<strong> </strong>" withString:@""];
                htmlString = [NSString stringWithFormat:@"%@<div class='first-big'><p style='margin-top:10'>%@</div>",htmlString,currentString];
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



-(NSString*)htmlRemoveReferences:(NSString*)htmlString{
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    htmlString = [NSString stringWithFormat:@"<XML>%@</XML>" , htmlString];
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:htmlString options:0 error:nil];
    GDataXMLElement *xmlEle = [xmlDoc rootElement];
    NSArray *array = [xmlEle children];

    for (int i = 0; i < [array count]; i++) {
        GDataXMLElement *ele = [array objectAtIndex:i];
//        NSLog(@"%d---%@",i,[ele stringValue]);
        
        if([[ele stringValue] rangeOfString:@"References"].location != NSNotFound){
            int referencesContentIndex = i+1;
            if(referencesContentIndex<[array count]){
                GDataXMLElement *eleOl = [array objectAtIndex:referencesContentIndex];
                if([[eleOl name]isEqualToString:@"ol"]){
                    for(int j=0;j<[eleOl childCount];j++){
                        GDataXMLElement *eleLi = (GDataXMLElement*)[eleOl childAtIndex:j];
                        if([[eleLi name]isEqualToString:@"li"]){
//                            NSLog(@"(%d)---%@",j,[eleLi stringValue]);
                            [mutableArray addObject:[eleLi stringValue]];
                        }
                    }
                    
                    [xmlEle removeChild:ele];
                    [xmlEle removeChild:eleOl];
                    break;
                }
            }
        }
    }
    
   
    referencesArray = [mutableArray copy];
    
    htmlString = [xmlEle XMLString];
    htmlString = [htmlString substringWithRange:NSMakeRange(5, htmlString.length-11)];
//    NSLog(@"xmlstring = %@",htmlString);
    
    
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  
    if([request.URL.absoluteString isEqualToString:@"about:blank"]){
        return YES;
    }else if([self needRedirect:request.URL]){
        return NO;
    }else{
        return [self handleCustomAction:request.URL];
    }
}

-(BOOL)needRedirect:(NSURL*)URL{
    NSDictionary *urlDic = [self urlToParamDic:URL.absoluteString];
    if([URL.absoluteString hasPrefix:@"https://adbutler-fermion.com/redirect.spark"] && urlDic[@"CID"]){
//        https://adbutler-fermion.com/redirect.spark?MID=174518&plid=853721&setID=332775&channelID=0&CID=266276&banID=519639830&PID=0&textadID=0&tc=1&mt=1543209928258293&sw=375&sh=667&spr=2&hc=abff94d8f50b86b21f108dea2890ea04c14fda5b&location=
        //处理服务商跳转
        [self.vc showLoading];
        WeakSelf
        [Proto getAdbutlerSponsor:^(NSDictionary* dic){
            foreTask(^{
                [weakSelf.vc hideLoading];
                if(dic && dic[urlDic[@"CID"]]){
                    NSString *name = [dic[urlDic[@"CID"]] uppercaseString];
                    NSDictionary *sponsorInfo = @{@"ALIGN":@"260",
                                                  @"NOBEL":@"259",
                                                  @"GSK":@"197"};
                    if(sponsorInfo[name]){
                        NSString *return_url =  [@"dsodentistapp://com.thenextmediagroup.dentist/openSponsor?sponsorId=" stringByAppendingString:sponsorInfo[name]];
                        [weakSelf handleCustomAction:[NSURL URLWithString:return_url]];
                    }
                    
                }
            });
        }];
        return YES;
    }else if([URL.absoluteString hasPrefix:@"https://adbutler-fermion.com/redirect.spark"]){
        //处理服务商跳转 此方案暂时不用
        [self.vc showLoading];
        WeakSelf
        backTask(^{
            NSString *urlString = [Proto getRedirectUrl:URL.absoluteString];
            
            foreTask(^{
                [weakSelf.vc hideLoading];
                if(urlString){
                    NSString *sponsor_old = @"https://mobile.dsodentist.com/posts/sponsor/";
                    NSString *sponsor_new = @"dsodentistapp://com.thenextmediagroup.dentist/openSponsor?sponsorId=";
                    
                    NSString *return_url = [urlString stringByReplacingOccurrencesOfString:sponsor_old withString:sponsor_new];
                    [weakSelf handleCustomAction:[NSURL URLWithString:return_url]];
                }
            });
        });
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)handleCustomAction:(NSURL*)URL{
    //dsodentistapp://com.thenextmediagroup.dentist/openCMSDetail?articleId=5be29d5f0e88c608b8186e52
    //dsodentistapp://com.thenextmediagroup.dentist/openSponsor?sponsorId=260
    
    NSString *localScheme = @"dsodentistapp";
    NSString *localSchemeAndHost = [NSString stringWithFormat:@"%@://%@/",localScheme,@"com.thenextmediagroup.dentist"];

    NSString *scheme = [URL scheme];
    NSString *urlStr = [URL absoluteString];
    NSLog(@"handleCustomAction url=%@",urlStr);
    

    
    NSRange range = [urlStr rangeOfString:localSchemeAndHost];
    if ([scheme isEqualToString:localScheme] && range.location != NSNotFound) {
        NSString *actionAndParams = [urlStr substringFromIndex:range.length];
        NSArray *array = [actionAndParams componentsSeparatedByString:@"?"];
        NSString *action = array[0];
        NSDictionary *paramDic = nil;
        if(array.count>1){
            paramDic = [self urlToParamDic:array[1]];
        }
        
        NSLog(@"handleCustomAction aciton=%@,dic=%@",action,paramDic);
        //处理ation
        if([action isEqualToString:@"openCMSDetail"]){
            [self openCMSDetail:paramDic];
        }else if([action isEqualToString:@"openSponsor"]){
            [self openSponsor:paramDic];
        }
    }
    return NO;
}

-(NSDictionary*)urlToParamDic:(NSString*)str{
    NSArray *array = [str componentsSeparatedByString:@"?"];
    str = [array lastObject];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    NSArray *paramArray = [str componentsSeparatedByString:@"&"];
    for(int i=0;i<paramArray.count;i++){
        NSString *itemStr = paramArray[i];
        NSArray *arr = [itemStr componentsSeparatedByString:@"="];
        if(arr.count>=2){
            paramDic[arr[0]] = arr[1];
        }
    }
    return [paramDic copy];
}

//dsodentistapp://com.thenextmediagroup.dentist/openCMSDetail?articleId=5be29d5f0e88c608b8186e52
-(void)openCMSDetail:(NSDictionary*)paramDic{
    
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    newVC.contentId = paramDic[@"articleId"];

    [self.vc.navigationController pushViewController:newVC animated:YES];
}



//dsodentistapp://com.thenextmediagroup.dentist/openSponsor?sponsorId=260
-(void)openSponsor:(NSDictionary*)paramDic{
    NSDictionary *sponsorInfo = @{@"260":@"sponsor_align",
                                  @"259":@"sponsor_nobel",
                                  @"197":@"sponsor_gsk"};
    
    if(sponsorInfo[paramDic[@"sponsorId"]]){
        GSKViewController *gskVC = [GSKViewController new];
        gskVC.sponsorId= paramDic[@"sponsorId"];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:gskVC];
        [self.vc presentViewController:navVC animated:YES completion:NULL];
    }
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

- (void)calcWebViewHeight:(NSTimer*)timer {
    //获取到webview的高度
    CGFloat webViewHeight1 = [[mywebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//    CGFloat webViewHeight2 = [[mywebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    CGFloat webViewHeight3 = [[mywebView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
//
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
    
//    NSLog(@"-----------------%d",calcWebViewHeightTimes);
}

#pragma mark  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([tableView isEqual:referencesTableView]){
        return referencesArray.count>0?1:0;
    }else{
        return relativeTopicArray.count>0?1:0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:referencesTableView]){
        return referencesArray.count;
    }else{
        return relativeTopicArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title = @"";
    if([tableView isEqual:referencesTableView]){
        title = @"References";
    }else{
        title = @"Related Resources";
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREENWIDTH,40)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = rgbHex(0x4a4a4a);
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary *dic = @{NSFontAttributeName:[Fonts medium:16], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.2f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:title attributes:dic];
    titleLabel.attributedText = attributeStr;
    
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if([tableView isEqual:referencesTableView] && referencesArray.count>5){
        return 50;
    }else{
        return 0;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if([tableView isEqual:referencesTableView] && referencesArray.count>5){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREENWIDTH - 2 * edge,50)];
        view.backgroundColor = argbHex(0xccffffff);
        
        UIButton *button = view.addButton;
        [[[[[button.layoutMaker topParent:referencesMoreMode?0:25]leftParent:0]rightParent:0]bottomParent:0]install];
        button.backgroundColor = UIColor.whiteColor;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        [button setTitleColor:Colors.primary forState:UIControlStateNormal];
        [button title:referencesMoreMode ? @"See less" : @"See more"];
        [button addTarget:self action:@selector(toggleReferencesMoreMode) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
   
    cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([tableView isEqual:referencesTableView]){
        return [self configReferencesCell:cell IndexPath:indexPath];
    }else{
        return [self configRelativeTopicCell:cell IndexPath:indexPath];
    }
}

-(void)toggleReferencesMoreMode{
    referencesMoreMode = !referencesMoreMode;
    [self showReferences:referencesArray];
}

-(UITableViewCell *)configReferencesCell:(UITableViewCell*)cell IndexPath:(NSIndexPath *)indexPath{
    UILabel *numberLabel = cell.contentView.addLabel;
    numberLabel.font = [Fonts regular:16];
    numberLabel.textColor = UIColor.blackColor;
    numberLabel.numberOfLines = 0;
    numberLabel.lineBreakMode = NSLineBreakByWordWrapping;
    numberLabel.text = [NSString stringWithFormat:@"%ld.",indexPath.row+1];
    [[[[numberLabel.layoutMaker leftParent:18] topParent:5]  widthEq:22]  install];
    
    UILabel *titleLabel = cell.contentView.addLabel;
    titleLabel.font = [Fonts regular:14];
    titleLabel.textColor = rgbHex(0x4a4a4a);
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.text = referencesArray[indexPath.row];
    [[[[[titleLabel.layoutMaker toRightOf:numberLabel offset:0]rightParent:0]topParent:5]  bottomParent:-5]  install];
    
    return cell;
}

-(UITableViewCell *)configRelativeTopicCell:(UITableViewCell*)cell IndexPath:(NSIndexPath *)indexPath{
    UILabel *titleLabel = cell.contentView.addLabel;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = rgbHex(0x0000ee);
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [[[[[titleLabel.layoutMaker leftParent:0]rightParent:0]topParent:5]  bottomParent:-5]  install];
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:relativeTopicArray[indexPath.row][@"title"] attributes:attribtDic];
    titleLabel.attributedText = attribtStr;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:relativeTopicTableView]){
        NSString *articleId = relativeTopicArray[indexPath.row][@"id"];
        NSString *url =[NSString stringWithFormat:@"dsodentistapp://com.thenextmediagroup.dentist/openCMSDetail?articleId=%@",articleId];
        [self handleCustomAction:[NSURL URLWithString:url]];
    }
}

- (void)timerInvalidate{
    if(calcWebViewHeightTimer && [calcWebViewHeightTimer isValid]){
        [calcWebViewHeightTimer invalidate];
        calcWebViewHeightTimer = nil;
    }
}
@end
