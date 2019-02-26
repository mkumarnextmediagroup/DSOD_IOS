//
//  XHStarRateView.h
//  XHStarRateView
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHStarRateView;

typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, RateStyle)
{
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

typedef NS_ENUM(NSInteger, StarStyle)
{
    StarStyleNormal = 0, 
    StarStyleCourse = 1
};

@protocol XHStarRateViewDelegate <NSObject>

-(void)starRateView:(XHStarRateView *)starRateView currentScore:(CGFloat)currentScore;

@end

@interface XHStarRateView : UIView

@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)RateStyle rateStyle;    //评分样式    默认是WholeStar
@property (nonatomic,assign)StarStyle startStyle;    //评分样式    默认是WholeStar
@property (nonatomic, weak) id<XHStarRateViewDelegate>delegate;
@property (nonatomic,assign)CGFloat currentScore;   // 当前评分：0-5  默认0

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame starStyle:(StarStyle)starStyle;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;


-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;
- (void)userTapRateView:(UITapGestureRecognizer *)gesture;
- (void)layoutSubviews;
- (void)setCurrentScore:(CGFloat)currentScore;

@end
