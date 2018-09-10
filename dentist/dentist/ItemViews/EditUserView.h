//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditUserView : UIControl

@property(readonly) UIImageView *headerImg;
@property(readonly) UIButton *editBtn;
@property(copy, nonatomic) void (^editBtnClickBlock)(void);

@end