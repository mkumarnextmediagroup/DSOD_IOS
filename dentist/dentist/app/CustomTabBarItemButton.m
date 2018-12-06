//
//  CustomTabBarItemButton.m
//  WHCTabBarController
//
//  Created by Dustin on 17/3/21.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "CustomTabBarItemButton.h"

@implementation CustomTabBarItemButton

- (instancetype)initWithFrame:(CGRect)frame imgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName titleColor:(UIColor *)color title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        // 设置文字，字号，图片，文字颜色
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:135/255.0 green:154/255.0 blue:168/255.0 alpha:1.0] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
        
        // 设置文字和图片的位置
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

#pragma mark 设置高亮状态的方法
// 在这个方法里面，系统会默认给按钮设置高亮状态的的情景
// 覆盖此方法，会使按钮的高亮状态不呈现任何情景
- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark 设置文字frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    // 标签视图高度占按钮高度的1/3
    return CGRectMake(0, self.bounds.size.height / 3 * 2-10, self.bounds.size.width, self.bounds.size.height / 3);
}

#pragma mark 设置图片frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    // 图片视图高度占按钮高度的2/3
    return CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 3 * 2);
}


@end
