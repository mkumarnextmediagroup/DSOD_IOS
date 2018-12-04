//
//  CustomTabbar.m
//  dentist
//
//  Created by 孙兴国 on 2018/12/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CustomTabbar.h"
#import "CustomTabBarItemButton.h"
#import "Common.h"

@interface CustomTabBar ()

@property (nonatomic,assign) NSInteger itemCount;// 子控制器个数
@property (nonatomic,assign) UIButton *previousBtn;// 前一个被点击的按钮

@end

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount
{
    if (self = [super initWithFrame:frame]) {
        // 保存按钮个数
        _itemCount = itemCount;
        
        // 设置背景颜色
        self.backgroundColor = [UIColor whiteColor];
        
        // 创建按钮
        [self createBtn];
    }
    
    return self;
}

#pragma mark 创建tabBarItem
- (void)createBtn {
    // 循环创建按钮
    
    // 计算按钮的宽高
    CGFloat w = self.bounds.size.width / (self.itemCount+1);
    CGFloat h = self.bounds.size.height;
    NSArray *selectedImgArr = @[@"explore-light",@"findJob-light",@"myJobs-light",@"alert-light",@"more-light"];
    NSArray *normalImgarr = @[@"explore",@"findJob",@"myJobs",@"alert",@"more"];
    NSArray *titleArr = @[@"Explore",@"Find Job",@"My Jobs",@"Alerts",@"More"];
    for (int i = 0; i < self.itemCount+1; i ++) {
        
        CustomTabBarItemButton *btn = [[CustomTabBarItemButton alloc] initWithFrame:CGRectMake(i * w, 0, w, h) imgName:normalImgarr[i] selectedImgName:selectedImgArr[i] titleColor:[UIColor colorWithRed:209/255.0 green:208/255.0 blue:208/255.0 alpha:1.0] title:titleArr[i]];
        btn.tag = 100+i;
        // 添加按钮的点击事件
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        if (i == 0) {
            [self btnClicked:btn];
        }
        
    }
    UILabel *lineLab = self.addLabel;
    [[[[lineLab.layoutMaker sizeEq:SCREENWIDTH h:1] topParent:0] leftParent:0] install];
    lineLab.backgroundColor = Colors.cellLineColor;
    
}

#pragma mark tabBarItem被点击让代理使UITabBarController的子控制器与其对应
- (void)btnClicked:(UIButton *)btn {
    
//    if (0 == btn.tag) {
        _previousBtn.selected = NO;
        btn.selected = YES;
        
        _previousBtn = btn;
        
//    }
    if ([_delegate respondsToSelector:@selector(myTabbar:btnClicked:)]) {
        [_delegate myTabbar:self btnClicked:(btn.tag-100)];
    }
}

-(void)setTabbarSelected:(NSInteger)index
{
    if (self.itemCount+1>index) {
        for (int i = 0; i < self.itemCount+1; i ++) {
            UIView *subview=[self viewWithTag:100+i];
            if ([subview isKindOfClass:[CustomTabBarItemButton class]]) {
                CustomTabBarItemButton *btn=(CustomTabBarItemButton *)subview;
                if (index == i) {
                    btn.selected = YES;
                    if ([_delegate respondsToSelector:@selector(myTabbar:btnClicked:)]) {
                        [_delegate myTabbar:self btnClicked:(btn.tag-100)];
                    }
                }else{
                    btn.selected = NO;
                }
            }
            
        }
    }
}

#pragma mark 当按钮超过了父视图范围，点击是没有反应的。因为消息的传递是从最下层的父视图开始调用hittest方法。当存在view时才会传递对应的event，现在点击了父视图以外的范围，自然返回的是nil。所以当子视图（比如按钮btn）因为一些原因超出了父视图范围，就要重写hittest方法，让其返回对应的子视图，来接收事件。
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        
        UIButton *btn = (UIButton *)[self viewWithTag:102];
        CGPoint tempoint = [btn convertPoint:point fromView:self];
        //判断给定的点是否被一个CGRect包含,可以用CGRectContainsPoint函数
        if (CGRectContainsPoint(btn.bounds, tempoint))
        {
            view = btn;
        }
    }
    return view;
}


@end
