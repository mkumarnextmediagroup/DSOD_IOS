//
//  DownloadsItemView.m
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DownloadsItemView.h"
#import "Common.h"
#import "Article.h"
#import "RMDownloadIndicator.h"
#import "CMSModel.h"
#import "Proto.h"
@implementation DownloadsItemView{
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
    UIButton *statusButton;
    UILabel *statusLabel;
    UIImageView *thumbImageView;
}

- (AFURLSessionManager *)manager {
    if (!_manager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 1. 创建会话管理者
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return _manager;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    imageView = self.addImageView;
   [[[[[imageView.layoutMaker leftParent:edge]topParent:25] bottomParent:-edge] sizeEq:110 h:110] install];
    
    thumbImageView = [UIImageView new];
    [imageView addSubview:thumbImageView];
    [[[[thumbImageView.layoutMaker leftParent:10] bottomParent:-10] sizeEq:28 h:28] install];
    
    _markButton = [self addButton];
    [_markButton setImage:[UIImage imageNamed:@"dot3"] forState:UIControlStateNormal];
    [_markButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [[[[_markButton.layoutMaker rightParent:-edge] topParent:25] sizeEq:20 h:20] install];
    
    statusButton = [self addButton];
    [statusButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [[[[statusButton.layoutMaker rightParent:-edge] bottomOf:imageView offset:0] sizeEq:20 h:20] install];
    statusButton.hidden=YES;
    
    _closedIndicator=[[RMDownloadIndicator alloc]initWithFrame:CGRectMake(self.frame.size.width-20-20, self.frame.size.height-20-20, 20, 20) type:kRMClosedIndicator];
    [_closedIndicator setBackgroundColor:[UIColor whiteColor]];
    [_closedIndicator setFillColor:[UIColor colorWithRed:0.0/255 green:122.0/255 blue:185.0/255 alpha:1.0f]];
    [_closedIndicator setStrokeColor:[UIColor colorWithRed:0.0/255 green:122.0/255 blue:185.0/255 alpha:1.0f]];
    _closedIndicator.radiusPercent = 0.45;
    [self addSubview:_closedIndicator];
     [_closedIndicator loadIndicator];
    [[[[_closedIndicator.layoutMaker rightParent:-edge] bottomOf:imageView offset:0] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts regular:14];
    titleLabel.textColor=Colors.textMain;
    [[[[[titleLabel.layoutMaker toRightOf:imageView offset:15] topOf:imageView offset:5] toLeftOf:_markButton offset:-10] heightEq:18] install];
    
    statusLabel = [self addLabel];
    statusLabel.font =[Fonts semiBold:12];
    statusLabel.textColor=Colors.textAlternate;
    statusLabel.numberOfLines = 0;
    [[[[[statusLabel.layoutMaker toRightOf:imageView offset:15] toLeftOf:_markButton offset:-20] bottomOf:imageView offset:0] heightEq:20] install];
    
    contentLabel = [self topShowLabel];
    contentLabel.font = [Fonts semiBold:15];
    contentLabel.textColor=Colors.textContent;
    contentLabel.numberOfLines = 3;
//    contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [[[[[contentLabel.layoutMaker toRightOf:imageView offset:15] below:titleLabel offset:5] rightParent:-edge] above:statusLabel offset:-5] install];
    
    return self;
}

- (void)bind:(Article *)item {
    statusLabel.text=@"Download complete";
    titleLabel.text = item.type;
    contentLabel.text = item.title;//[item.title stringByAppendingString:@"\n\n\n\n "];
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    [imageView scaleFillAspect];
    imageView.clipsToBounds=YES;
    if ([item.categoryName isEqualToString:@"VIDEOS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Video"]];
    }else if([item.categoryName isEqualToString:@"PODCASTS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Podcast"]];
    }else if([item.categoryName isEqualToString:@"INTERVIEWS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Interview"]];
    }else if([item.categoryName isEqualToString:@"TECH GUIDES"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TechGuide"]];
    }else if([item.categoryName isEqualToString:@"ANIMATIONS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Animation"]];
    }else if([item.categoryName isEqualToString:@"TIP SHEETS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TipSheet"]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
    
    
}
-(void)bindCMS:(CMSModel *)item
{
    _cmsmodel=item;
    statusLabel.text=@"Download starting...";
    titleLabel.text = _cmsmodel.categoryName;
    contentLabel.text = _cmsmodel.title;
    NSString *urlstr;
    if (_cmsmodel.featuredMediaId) {
        urlstr=[Proto getFileUrlByObjectId:_cmsmodel.featuredMediaId];
    }
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
    [imageView scaleFillAspect];
    imageView.clipsToBounds=YES;
    if ([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"VIDEOS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Video"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"PODCASTS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Podcast"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"INTERVIEWS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Interview"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"TECH GUIDES"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TechGuide"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"ANIMATIONS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Animation"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"TIP SHEETS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TipSheet"]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
    if([_cmsmodel.downstatus integerValue]==5){
        [self downdone];
    }else{
       [self startAnimation];
    }
}

-(void)startAnimation
{
    typeof(self) __weak weakself = self;
    self.downloadedBytes = 0;
    _closedIndicator.hidden=NO;
    statusButton.hidden=YES;
    statusLabel.text=@"Download starting...";
    [_closedIndicator updateWithTotalBytes:100 downloadedBytes:0];
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(1.0* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(time, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(time, ^{
        
        //设置当执行完成取消定时器
        if([weakself.cmsmodel.downstatus integerValue]==5){
            dispatch_async(dispatch_get_main_queue(), ^(){
                [weakself downdone];
            });
            dispatch_cancel(time);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^(){
                
                [weakself updateProgressView:20];
            });
            
            if(weakself.downloadedBytes >= 100){
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [weakself downdone];
                });
                dispatch_cancel(time);
                
            }
        }
        
    });
    //启动定时器
    dispatch_resume(time);
    
}

-(void)downdone
{
    statusLabel.text=@"Download complete";
    _closedIndicator.hidden=YES;
    statusButton.hidden=NO;
}

- (void)updateProgressView:(CGFloat)val
{
    self.downloadedBytes+=val;
    NSString *statusstr=[NSString stringWithFormat:@"Downloaded %@%@",@(self.downloadedBytes),@"%"];
//    statusLabel.text=statusstr;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:statusstr];
    [str addAttribute:NSForegroundColorAttributeName value:Colors.textContent range:NSMakeRange(10,statusstr.length - 10)];
    statusLabel.attributedText = str;
    [_closedIndicator updateWithTotalBytes:100 downloadedBytes:self.downloadedBytes];
}

-(void)moreAction:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMoreAction:)]){
        [self.delegate ArticleMoreAction:_cmsmodel.id];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMoreActionModel:)]){
        [self.delegate ArticleMoreActionModel:_cmsmodel];
    }
}

@end
