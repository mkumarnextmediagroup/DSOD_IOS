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

@implementation PicDetailView
{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UIImageView *imageView;
    UIImageView *headerImg;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *contentLabel;
    UIView *view;
    UILabel *contentLabel2;
    UIScrollView *imageScroll;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    
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
    [[[[_moreButton.layoutMaker rightParent:-edge] below:imageView offset:edge] sizeEq:20 h:20] install];
    
    _markButton = [self addButton];
    [_markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[_markButton.layoutMaker toLeftOf:_moreButton offset:-8] below:imageView offset:edge] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:20];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 0;
    [[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] install];
    [titleLabel.layoutMaker.height.equalTo(@24).priority(200) install];
    
    UILabel *lineLabel = [self lineLabel];
    [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] below:titleLabel offset:15] heightEq:1] install];
    
    view = [UIView new];
    [self addSubview:view];
    [[[[[view.layoutMaker leftParent:0] rightParent:0] below:lineLabel offset:0] heightEq:58] install];
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
    
    contentLabel = [self addLabel];
    contentLabel.font = [Fonts regular:15];
    [contentLabel textColorMain];
    contentLabel.numberOfLines = 0;
    [[[[contentLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:view offset:5] install];
    
    UIImageView *imgCon = [UIImageView new];
    imgCon.image = [UIImage imageNamed:@"contentPic_bg"];
    [self addSubview:imgCon];
    [[[[[imgCon.layoutMaker sizeEq:SCREENWIDTH h:298] leftParent:0] rightParent:0] below:contentLabel offset:25] install];
    
    contentLabel2 = [self addLabel];
    contentLabel2.font = [Fonts regular:15];
    [contentLabel2 textColorMain];
    contentLabel2.numberOfLines = 0;
    [[[[contentLabel2.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:imgCon offset:15] install];
    
    UILabel *lineLabel3 = [self lineLabel];
    [[[[[lineLabel3.layoutMaker leftParent:0] rightParent:0] below:contentLabel2 offset:25] heightEq:1] install];
    
    [self moreView];
    [self createStarView];
    
    return self;
}

- (void)moreView{
    
    UIView *moreView = [UIView new];
    [self addSubview:moreView];
    [[[[[[moreView.layoutMaker leftParent:0] leftParent:0] rightParent:0] heightEq:202] below:contentLabel2 offset:26] install];
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
        [imgBtn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.frame = CGRectMake(EDGE + (133 + 10) * i, 4, 133, 133);
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
    star.tag = 1;
    [starView addSubview:star];
    
    UILabel *lineLabel4 = [starView lineLabel];
    [[[[[lineLabel4.layoutMaker leftParent:0] rightParent:0]
       topParent:99] heightEq:1] install];
    [starView.layoutMaker.bottom.equalTo(self.mas_bottom) install];
    
    
}

- (void)bind:(Article *)bindInfo {
    typeLabel.text = [bindInfo.type uppercaseString];
    dateLabel.text = bindInfo.publishDate;
    [imageView loadUrl:@"https://www.dsodentist.com/assets/images/slide/slide-1.jpg" placeholderImage:@"art-img"];
    [headerImg loadUrl:@"http://app800.cn/i/p.png" placeholderImage:@"user_img"];
    titleLabel.text = bindInfo.title;
    nameLabel.text = bindInfo.authName;
    addressLabel.text = bindInfo.authAdd;
    contentLabel.text = bindInfo.content;
    contentLabel2.text = bindInfo.subContent;
}

- (void)resetLayout {
    CGSize size = [contentLabel sizeThatFits:CGSizeMake(290, 1000)];
    CGSize size2 = [contentLabel2 sizeThatFits:CGSizeMake(290, 1000)];
    [[contentLabel.layoutUpdate heightEq:size.height] install];
    [[contentLabel2.layoutUpdate heightEq:size2.height] install];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
