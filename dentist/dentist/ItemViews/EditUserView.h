//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditUserView : UIControl

@property(readonly) UIImageView *headerImg;
@property(readonly) UIButton *editBtn;
@property(nonatomic,strong) NSString *avatarUrl;
@property(readonly) UILabel *percentageLab;
@property(readonly) UIProgressView * pView;
@property(nonatomic) float percent;


-(void)reset:(float)percent;

@end
