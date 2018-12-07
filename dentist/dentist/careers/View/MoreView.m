//
//  MoreView.m
//  dentist
//
//  Created by 孙兴国 on 2018/12/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "MoreView.h"

#define offBottom IPHONE_X?85:50

@implementation MoreView
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    
    float angle;
    float imageviewAngle;
    
    BOOL isTouch;
}
static MoreView *instance;
static dispatch_once_t onceToken;

+(void)attemptDealloc{
    instance = nil;
    onceToken = 0;
}

+ (instancetype)initSliderView
{
    dispatch_once(&onceToken, ^{
        instance = [[MoreView alloc] init];
        CGFloat bottom = offBottom;
        instance.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT-bottom);
        instance.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.8];
        [instance initSubView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController.view addSubview:instance];
    });
    
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        UITapGestureRecognizer *tapMore =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMoreBack:)];
        [self addGestureRecognizer:tapMore];
    }
    return self;
}

-(void)tapMoreBack:(UITapGestureRecognizer *)tap
{
    [self hideFuntionBtn];
}

- (void)initSubView
{
    //初始化背景图
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-160, self.frame.size.height, 140, 40)];
    [btn1 setImage:[UIImage imageNamed:@"more-me"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"Me" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    btn1.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    
    btn2 = [[UIButton alloc] initWithFrame:btn1.frame];
    [btn2 setImage:[UIImage imageNamed:@"more-notification"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"Notifications" forState:UIControlStateNormal];
    btn2.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    
    btn3 = [[UIButton alloc] initWithFrame:btn1.frame];
    [btn3 setImage:[UIImage imageNamed:@"more-reviews"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"Reviews" forState:UIControlStateNormal];
    btn3.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn3.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    
    btn4 = [[UIButton alloc] initWithFrame:btn1.frame];
    [btn4 setImage:[UIImage imageNamed:@"more-profiles"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"DSO Profiles" forState:UIControlStateNormal];
    btn4.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    btn4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn4.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    
    [self addSubview:btn2];
    [self addSubview:btn3];
    [self addSubview:btn1];
    [self addSubview:btn4];
    
}

- (void)showFuntionBtn
{
    CGFloat bottom = offBottom;
    if (self.frame.origin.y == SCREENHEIGHT) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame = CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT-bottom);
        }];
    }else
    {
        [UIView animateWithDuration:.3 animations:^{
            self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT-bottom);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [MoreView attemptDealloc];
        }];
    }
    
    if (!isTouch) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        
        CGRect frame1 = btn1.frame;
        frame1.origin.y -= 50;
        [btn1 setFrame:frame1];
        
        CGRect frame2 = btn2.frame;
        frame2.origin.y -= 120;
        [btn2 setFrame:frame2];
        
        CGRect frame3 = btn3.frame;
        frame3.origin.y -= 190;
        [btn3 setFrame:frame3];
        
        CGRect frame4 = btn4.frame;
        frame4.origin.y -= 260;
        [btn4 setFrame:frame4];
        
        [UIView commitAnimations];
        
        isTouch = YES;
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        
        CGRect frame1 = btn1.frame;
        frame1.origin.y += 50;
        [btn1 setFrame:frame1];
        
        CGRect frame2 = btn2.frame;
        frame2.origin.y += 120;
        [btn2 setFrame:frame2];
        
        CGRect frame3 = btn3.frame;
        frame3.origin.y += 190;
        [btn3 setFrame:frame3];
        
        CGRect frame4 = btn4.frame;
        frame4.origin.y += 260;
        [btn4 setFrame:frame4];
        
        [UIView commitAnimations];
        
        isTouch = NO;
    }
    
}
- (void)hideFuntionBtn
{
    CGFloat bottom = offBottom;
    [UIView animateWithDuration:.3 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT-bottom);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [MoreView attemptDealloc];
    }];
}

#pragma -mark -functions
- (void)btnClick:(id)sender
{
    NSLog(@"morebuttonclick");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
