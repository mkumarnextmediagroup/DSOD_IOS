//
//  BannerView.m
//  dentist
//
//  Created by fengzhenrong on 2018/10/16.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "BannerScrollView.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "GenericCoursesModel.h"
#import "XHStarRateView.h"

@interface BannerScroll : UIScrollView
{
    
}
@end

@implementation BannerScroll

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}

@end

@interface BannerScrollView ()<UIScrollViewDelegate>
{
    NSInteger pageCount;
    NSInteger realpageCount;
    NSTimeInterval autoTimeInterval;
    dispatch_source_t timegcd;
    dispatch_queue_t queue;
    NSInteger currentPageIndex;
    BOOL isend;
    BOOL isstart;
}

@property (nonatomic, strong) NSMutableArray *imageNameArray;
@property (nonatomic, strong) NSMutableArray *imageUrlArray;
@property (nonatomic, copy) NSArray<GenericCoursesModel *> *courseArray;
@property (nonatomic, strong) BannerScroll *scrollView;
//@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy)   ClickWithBlock clickWithBlock;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BannerScrollView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
    return self;
}

-(void)addWithImageNames:(NSArray *)imageNames clickBlock:(ClickWithBlock)block
{
    return [self addWithImageNames:imageNames autoTimerInterval:0 clickBlock:block];
}

-(void)addWithImageNames:(NSArray *)imageNames autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block
{
    realpageCount=imageNames.count;
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageNames];
    [tempArray insertObject:[imageNames objectAtIndex:([imageNames count]-1)] atIndex:0];
    [tempArray addObject:[imageNames objectAtIndex:0]];
    self.imageNameArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageUrlArray = [NSMutableArray array];
    pageCount = _imageNameArray.count;
    
    self.clickWithBlock = block;
    
    autoTimeInterval = timeInterval;
    
    [self initUI];
}

-(void)addWithImageNames:(NSArray *)imageNames courses:(NSArray<GenericCoursesModel *> *)coursearr autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block
{
    realpageCount=imageNames.count;
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageNames];
    [tempArray insertObject:[imageNames objectAtIndex:([imageNames count]-1)] atIndex:0];
    [tempArray addObject:[imageNames objectAtIndex:0]];
    self.imageNameArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageUrlArray = [NSMutableArray array];
    self.courseArray=coursearr;
    pageCount = _imageNameArray.count;
    
    self.clickWithBlock = block;
    
    autoTimeInterval = timeInterval;
    
    [self initUI];
}

-(void)addWithImageUrls:(NSArray *)imageUrls clickBlock:(ClickWithBlock)block
{
    return [self addWithImageUrls:imageUrls autoTimerInterval:0 clickBlock:block];
}

-(void)addWithImageUrls:(NSArray *)imageUrls autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block
{
    NSLog(@"imageUrls=%@",imageUrls);
    realpageCount=imageUrls.count;
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageUrls];
    [tempArray insertObject:[imageUrls objectAtIndex:([imageUrls count]-1)] atIndex:0];
    [tempArray addObject:[imageUrls objectAtIndex:0]];
    NSLog(@"tempArray=%@",tempArray);
    self.imageUrlArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageNameArray = [NSMutableArray array];
    pageCount = _imageUrlArray.count;
    self.clickWithBlock = block;
    
    autoTimeInterval = timeInterval;
    
    [self initUI];
}

-(void)addWithImageUrls:(NSArray *)imageUrls courses:(NSArray<GenericCoursesModel *> *)coursearr autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block
{
    NSLog(@"imageUrls=%@",imageUrls);
    realpageCount=imageUrls.count;
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageUrls];
    [tempArray insertObject:[imageUrls objectAtIndex:([imageUrls count]-1)] atIndex:0];
    [tempArray addObject:[imageUrls objectAtIndex:0]];
    NSLog(@"tempArray=%@",tempArray);
    self.imageUrlArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageNameArray = [NSMutableArray array];
    self.courseArray=coursearr;
    pageCount = _imageUrlArray.count;
    self.clickWithBlock = block;
    
    autoTimeInterval = timeInterval;
    
    [self initUI];
}

-(void)replaceImageUrls:(NSArray *)imageUrls clickBlock:(ClickWithBlock)block
{
    
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageUrls];
    [tempArray insertObject:[imageUrls objectAtIndex:([imageUrls count]-1)] atIndex:0];
    [tempArray addObject:[imageUrls objectAtIndex:0]];
    self.imageUrlArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageNameArray = [NSMutableArray array];
//    pageCount = _imageUrlArray.count;
    self.clickWithBlock = block;
    
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
        
    }
    [self addImageViews];
    
//    self.pageControl.numberOfPages = pageCount;
}

-(void)replaceImageNames:(NSArray *)imageNames clickBlock:(ClickWithBlock)block
{
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageNames];
    [tempArray insertObject:[imageNames objectAtIndex:([imageNames count]-1)] atIndex:0];
    [tempArray addObject:[imageNames objectAtIndex:0]];
    self.imageNameArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageUrlArray = [NSMutableArray array];
//    pageCount = _imageNameArray.count;
    self.clickWithBlock = block;
    
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
        
    }
    [self addImageViews];
    
//    self.pageControl.numberOfPages = pageCount;
}

-(void)replaceImageNames:(NSArray *)imageNames courses:(NSArray<GenericCoursesModel *> *)coursearr clickBlock:(ClickWithBlock)block
{
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imageNames];
    [tempArray insertObject:[imageNames objectAtIndex:([imageNames count]-1)] atIndex:0];
    [tempArray addObject:[imageNames objectAtIndex:0]];
    NSMutableArray *tempcourseArray=[NSMutableArray arrayWithArray:coursearr];
    if (coursearr.count != 0) {
        [tempcourseArray insertObject:[coursearr objectAtIndex:([coursearr count]-1)] atIndex:0];
        [tempcourseArray addObject:[coursearr objectAtIndex:0]];
    }
    self.imageNameArray = [NSMutableArray arrayWithArray:tempArray];
    self.imageUrlArray = [NSMutableArray array];
    self.courseArray=tempcourseArray;
    self.clickWithBlock = block;
    
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    [self addImageViews];
}

-(void)initUI
{
    [self addSubview:self.scrollView];
    [self addImageViews];
    [self addSubview:self.pageControl];
    
    self.pageIndicatorTintColor = [UIColor grayColor];
    self.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    //默认居中对齐
    self.pageAlign = BannerPageAlignCenter;
    [[[[[_scrollView.layoutMaker topParent:0] leftParent:0] bottomParent:0] rightParent:0] install];
    [self layoutIfNeeded];
    NSLog(@"_scrollViewframe=%@",NSStringFromCGRect(_scrollView.frame));
    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*pageCount, _scrollView.frame.size.height);
    
    if (pageCount > 1) {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * 1, 0) animated:NO];
        //分页view显示第一页
        self.pageControl.currentPage = 0;
    }
    
    [self beginAutoChange];
}

-(void)setPageAlign:(BannerPageAlign)pageAlign
{
    _pageAlign = pageAlign;
    _pageControl.hidden = NO;
    if (pageAlign == BannerPageAlignNone) {
        _pageControl.hidden = YES;
    }else if (pageAlign == BannerPageAlignLeft){
        
        [[[[_pageControl.layoutMaker leftParent:10] bottomParent:0] heightEq:30] install];
    }else if (pageAlign == BannerPageAlignCenter){
        [[[[_pageControl.layoutMaker centerXParent:0] bottomParent:0] heightEq:30] install];
    }else if (pageAlign == BannerPageAlignRight){
        [[[[_pageControl.layoutMaker rightParent:-10] bottomParent:0] heightEq:30] install];
    }
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

-(UIScrollView *)scrollView
{
    if (_scrollView != nil) {
        return _scrollView;
    }
    
    self.scrollView = [[BannerScroll alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    return _scrollView;
}

-(void)addImageViews
{
    UIImageView *lastImageView = nil;
    
    for (int i=0; i<pageCount; i++) {
        lastImageView = [self addImageViewIndex:i lastView:lastImageView];
    }
    
}

//返回图片
-(UIImageView *)addImageViewIndex:(NSInteger)i lastView:(UIImageView *)lastImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.tag=i;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    [self.scrollView addSubview:imageView];
    if(lastImageView){
        [[[[[imageView.layoutMaker toRightOf:lastImageView offset:0] topParent:0] heightOf:self.scrollView] widthOf:self.scrollView] install];
    }else{
        [[[[[imageView.layoutMaker leftParent:0] topParent:0] heightOf:self.scrollView] widthOf:self.scrollView] install];
    }
    
    //add 课程信息
    if(self.courseArray && self.courseArray.count>i){
        GenericCoursesModel *model=self.courseArray[i];
        UILabel *priceLabel=[imageView addLabel];
        priceLabel.textColor=[UIColor whiteColor];
        priceLabel.font=[UIFont systemFontOfSize:15];
        priceLabel.textAlignment=NSTextAlignmentRight;
        priceLabel.text=[NSString stringWithFormat:@"$%.2f",model.price];
        [[[[priceLabel.layoutMaker rightParent:-20] bottomParent:-28] sizeEq:60 h:20] install];
       XHStarRateView *starview = [[XHStarRateView alloc] initWithFrame:CGRectMake(25, 50, 92, 16) starStyle:StarStyleCourse];
        starview.userInteractionEnabled = NO;
        starview.isAnimation = NO;
        starview.currentScore=model.rating;
        [imageView addSubview:starview];
        [[[[starview.layoutMaker leftParent:25] centerYOf:priceLabel offset:0] sizeEq:60 h:16] install];
        
        UILabel *titleLabel=[imageView addLabel];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.font=[UIFont systemFontOfSize:17];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.text=model.name;
        [[[[titleLabel.layoutMaker leftParent:25] above:starview offset:-20] rightParent:-25] install];
    }
    
    
    if (_imageNameArray.count > 0) {
        [imageView setImage:[UIImage imageNamed:[_imageNameArray objectAtIndex:i]]];
    }else if (_imageUrlArray.count > 0){
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_imageUrlArray objectAtIndex:i]] placeholderImage:nil];
    }
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
    [Tap setNumberOfTapsRequired:1];
    [Tap setNumberOfTouchesRequired:1];
    imageView.userInteractionEnabled=YES;
    [imageView addGestureRecognizer:Tap];
    
    return imageView;
}

-(void)addCourseView
{
    
}

-(UIPageControl *)pageControl
{
    if (_pageControl != nil) {
        return _pageControl;
    }
    
    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = realpageCount;
    _pageControl.hidden = realpageCount <= 1;
    [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    return _pageControl;
}


//滚动视图滑动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endAutoChange];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginAutoChange];
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (currentPageIndex==0) {
        
        [_scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(pageCount-2), 0)];
    }
    if (currentPageIndex==(pageCount-1)) {
        
        [_scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    if (page == 0) {
        self.pageControl.currentPage = pageCount - 1;
    }else if (page == pageCount+1)
    {
        self.pageControl.currentPage = 0;
    }
    self.pageControl.currentPage = page-1;

}


//UIPageControl 索引改变
-(void)pageChange:(UIPageControl *)pageControl
{
    
}

//开始自动切换
-(void)beginAutoChange
{
    if (pageCount <= 1) {
        return;
    }
    
    if (autoTimeInterval == 0) {
        return;
    }
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:autoTimeInterval target:self selector:@selector(changeScrollPage) userInfo:nil repeats:YES];
    typeof(self) __weak weakself = self;
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    timegcd = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(3.0* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(timegcd, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(timegcd, ^{
        
        //设置当执行完成取消定时器
        dispatch_async(dispatch_get_main_queue(), ^(){
            [weakself changeScrollPage];
        });
    });
    //启动定时器
    dispatch_resume(timegcd);
}

-(void)changeScrollPage
{
    NSInteger pageNum = self.pageControl.currentPage;
    CGSize myViewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake((pageNum + 2) * myViewSize.width, 0, myViewSize.width, myViewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
    pageNum++;
    if (pageNum ==  pageCount - 2) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
}

//停止自动切换
-(void)endAutoChange
{
//    if (self.timer != nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
    if(timegcd){
        dispatch_cancel(timegcd);
    }
}

//点击
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if (sender.view.tag != 0 && sender.view.tag <=realpageCount)
    {
        if (self.clickWithBlock) {
            self.clickWithBlock(sender.view.tag);
        }
    }
}


//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
//            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
//            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
//            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
//            NSLog(@"屏幕向左横置");
            break;
        case UIDeviceOrientationLandscapeRight:
//            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
//            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
//            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
//            NSLog(@"无法辨识");
            break;
    }
    [self layoutIfNeeded];
//    NSLog(@"_scrollViewframe=%@",NSStringFromCGRect(_scrollView.frame));
    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*pageCount, _scrollView.frame.size.height);
    NSInteger pageNum = self.pageControl.currentPage;
    CGSize myViewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake((pageNum + 1) * myViewSize.width, 0, myViewSize.width, myViewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:NO];
    
}
//最后在dealloc中移除通知 和结束设备旋转的通知
- (void)dealloc{
    //...
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}

@end
