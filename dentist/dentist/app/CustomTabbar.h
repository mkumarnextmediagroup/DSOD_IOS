//
//  CustomTabbar.h
//  dentist
//
//  Created by 孙兴国 on 2018/12/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

- (void)myTabbar:(CustomTabBar *)tabbar btnClicked:(NSInteger)index;

@end

@interface CustomTabBar : UIView
/** 初始化方法
 参数1: 位置大小
 参数2: 内部按钮个数
 */
- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount;

@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;

@end
