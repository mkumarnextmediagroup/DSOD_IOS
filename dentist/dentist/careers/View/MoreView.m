//
//  MoreView.m
//  dentist
//
//  Created by 孙兴国 on 2018/12/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "MoreView.h"

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

+ (instancetype)initSliderView
{
    dispatch_once(&onceToken, ^{
        instance = [[MoreView alloc] init];
        instance.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8];
        [instance initSubView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController.view addSubview:instance];
        instance.frame = CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    });
    
    return instance;
}

- (void)initSubView
{
    //初始化背景图
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-60, self.frame.size.height, 40, 40)];
    
    [btn1 setImage:[UIImage imageNamed:@"more-me"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn2 = [[UIButton alloc] initWithFrame:btn1.frame];
    [btn2 setImage:[UIImage imageNamed:@"more-notification"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn3 = [[UIButton alloc] initWithFrame:btn1.frame];
    [btn3 setImage:[UIImage imageNamed:@"more-reviews"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn4 = [[UIButton alloc] initWithFrame:btn1.frame];
    [btn4 setImage:[UIImage imageNamed:@"more-profiles"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn2];
    [self addSubview:btn3];
    [self addSubview:btn1];
    [self addSubview:btn4];
    
    [self showFuntionBtn];

}

- (void)showFuntionBtn
{
    if (!isTouch) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        
        CGRect frame1 = btn1.frame;
        frame1.origin.y -= 110;
        [btn1 setFrame:frame1];
        
        CGRect frame2 = btn2.frame;
        frame2.origin.y -= 180;
        [btn2 setFrame:frame2];
        
        CGRect frame3 = btn3.frame;
        frame3.origin.y -= 250;
        [btn3 setFrame:frame3];
        
        CGRect frame4 = btn4.frame;
        frame4.origin.y -= 320;
        [btn4 setFrame:frame4];
        
        [UIView commitAnimations];
        
        isTouch = YES;
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        
        CGRect frame1 = btn1.frame;
        frame1.origin.y += 110;
        [btn1 setFrame:frame1];
        
        CGRect frame2 = btn2.frame;
        frame2.origin.y += 180;
        [btn2 setFrame:frame2];
        
        CGRect frame3 = btn3.frame;
        frame3.origin.y += 250;
        [btn3 setFrame:frame3];
        
        CGRect frame4 = btn4.frame;
        frame4.origin.y += 320;
        [btn4 setFrame:frame4];
        
        [UIView commitAnimations];
        
        isTouch = NO;
    }}

#pragma -mark -functions
- (void)btnClick:(id)sender
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
