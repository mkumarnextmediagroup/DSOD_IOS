//
//  XHStarRateView.m
//  XHStarRateView
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "XHStarRateView.h"
#import "UIImage+customed.h"
#import "Common.h"
#define ForegroundStarImage @"star_select"
#define BackgroundStarImage @"star_unselect"

#define ForegroundStarImage2 @"icon-star"
#define BackgroundStarImage2 @"ic_course_star"

typedef void(^completeBlock)(CGFloat currentScore);

@interface XHStarRateView()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@property (nonatomic,strong)completeBlock complete;

@end

@implementation XHStarRateView

#pragma mark - 代理方式
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _startStyle=StarStyleNormal;
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame starStyle:(StarStyle)starStyle {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _startStyle =starStyle;
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _startStyle=StarStyleNormal;
        _isAnimation = isAnimation;
        _delegate = delegate;
        [self createStarView];
    }
    return self;
}

#pragma mark - block方式
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _startStyle=StarStyleNormal;
        _complete = ^(CGFloat currentScore){ finish(currentScore); };
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _startStyle=StarStyleNormal;
        _isAnimation = isAnimation;
        _complete = ^(CGFloat currentScore) { finish(currentScore); };
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
-(void)createStarView{
    
    UIImage *foreimage=[UIImage imageNamed:ForegroundStarImage];
    UIImage *backimage=[UIImage imageNamed:BackgroundStarImage];;
    if (_startStyle == StarStyleCourse) {
        foreimage=[UIImage imageNamed:ForegroundStarImage2];;
        backimage=[foreimage imageChangeColor:Colors.strokes];
    }
    self.foregroundStarView = [self createStarViewWithImage:foreimage];
    self.backgroundStarView = [self createStarViewWithImage:backimage];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];

}

- (UIView *)createStarViewWithImageName:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    UIImage *starimage=[UIImage imageNamed:imageName];
    
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        CGFloat starimagex=i * self.bounds.size.width / self.numberOfStars;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:starimage];
        imageView.frame = CGRectMake(starimagex, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (UIView *)createStarViewWithImage:(UIImage *)starimage {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        CGFloat starimagex=i * self.bounds.size.width / self.numberOfStars;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:starimage];
        imageView.frame = CGRectMake(starimagex, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (_rateStyle) {
        case WholeStar: {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default: break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak XHStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}


-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    if ([self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        [self.delegate starRateView:self currentScore:_currentScore];
    }
    if (self.complete) { _complete(_currentScore); }
    [self setNeedsLayout];
}

@end
