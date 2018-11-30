//
//  CareerMoreViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//
//@"more-me"
//@"more-notification"
//@"more-reviews"
//@"more-profiles"
#import "CareerMoreViewController.h"

@interface CareerMoreViewController ()
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    
    float angle;
    float imageviewAngle;
    
    BOOL isTouch;
}
@end

@implementation CareerMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.7];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTappedPickerView:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
//    singleTap.delegate = self;

    UINavigationItem *item = [self navigationItem];
    item.title = @"More";

    //初始化背景图
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height, 40, 40)];
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
    
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn1];
    [self.view addSubview:btn4];
    
    [self showFuntionBtn];
    // Do any additional setup after loading the view.
}

- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender
{
    isTouch = YES;
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
