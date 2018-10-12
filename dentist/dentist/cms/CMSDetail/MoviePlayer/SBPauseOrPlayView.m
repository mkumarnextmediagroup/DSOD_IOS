//
//  PauseOrPlayView.m
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/11.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBPauseOrPlayView.h"
@interface SBPauseOrPlayView ()

@end
@implementation SBPauseOrPlayView

- (void)drawRect:(CGRect)rect {
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.imageBtn setShowsTouchWhenHighlighted:YES];
    [self.imageBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.imageBtn addTarget:self action:@selector(handleImageTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.imageBtn];
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.fastGoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.fastGoBtn.backgroundColor = [UIColor greenColor];
    [self.fastGoBtn setImage:[UIImage imageNamed:@"fastGo"] forState:UIControlStateNormal];
    [self.fastGoBtn addTarget:self action:@selector(fastGoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.fastGoBtn];
    [self.fastGoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(self.frame.size.width/2 + 40);
        make.bottom.mas_equalTo(self).offset(-self.frame.size.height/2 + 40);
        make.size.height.mas_equalTo(80);
    }];
    
    self.fastBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.fastBackBtn.backgroundColor = [UIColor greenColor];
    [self.fastBackBtn setImage:[UIImage imageNamed:@"fastBack"] forState:UIControlStateNormal];
    [self.fastBackBtn addTarget:self action:@selector(fastBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.fastBackBtn];
    [self.fastBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-self.frame.size.width/2 - 40);
        make.bottom.mas_equalTo(self).offset(-self.frame.size.height/2 + 40);
        make.size.height.mas_equalTo(80);
    }];
}

-(void)handleImageTapAction:(UIButton *)button{
    button.selected = !button.selected;
    _state = button.isSelected ? YES : NO;
    if ([self.delegate respondsToSelector:@selector(pauseOrPlayView:withState:)]) {
        [self.delegate pauseOrPlayView:self withState:_state];
    }
}

- (void)fastGoAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(fastGoAction:)]) {
        [self.delegate fastGoAction:self];
    }
}

- (void)fastBackAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(fastBackAction:)]) {
        [self.delegate fastBackAction:self];
    }
}


@end
