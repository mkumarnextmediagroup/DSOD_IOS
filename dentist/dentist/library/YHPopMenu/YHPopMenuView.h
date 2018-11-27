//
//  YHPopMenuView.h
//  PikeWay
//
//  Created by samuelandkevin on 16/10/25.
//  Copyright © 2016年 YHSoft. All rights reserved.
//  弹出菜单

#import <UIKit/UIKit.h>


typedef void(^DismissBlock)(BOOL isCanceled,NSInteger row);

@interface YHPopMenuView : UIView

@property (nonatomic,assign) CGFloat iconW;             //图标宽(默认宽高相等)
@property (nonatomic,assign) CGFloat fontSize;          //字体大小
@property (nonatomic,strong) UIColor *fontColor;        //字体颜色
@property (nonatomic,strong) UIColor *itemBgColor;      //item背景颜色
@property (nonatomic,assign) CGFloat itemNameRightSpace; //itemName右边距
@property (nonatomic,assign) CGFloat iconRightSpace;     //icon右边距离
@property (nonatomic,assign) CGFloat itemH;             //item高度
@property (nonatomic,copy) NSArray *iconNameArray;      //图标名字Array
@property (nonatomic,copy) NSArray *itemNameArray;      //item名字Array
@property (nonatomic,copy) NSArray *NonEnableArray;      //item名字Array

@property (nonatomic,assign) BOOL canTouchTabbar;//可以点击Tabbar;(默认是遮挡Tabbar)

@property (nonatomic,assign) BOOL isShowing;//是否正在显示

-(void)updateIcon:(NSString *)iconname atIndex:(NSInteger)atindex;
- (void)dismissHandler:(DismissBlock)handler;
- (void)show;
- (void)hide;
- (void)reloadData;
@end
