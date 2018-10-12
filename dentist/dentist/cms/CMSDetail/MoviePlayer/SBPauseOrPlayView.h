//
//  PauseOrPlayView.h
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/11.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCommonHeader.h"
@class SBPauseOrPlayView;
@protocol SBPauseOrPlayViewDelegate <NSObject>
@required
/**
 pause or paly status

 @param pauseOrPlayView 暂停或者播放视图
 @param state 返回状态
 */
-(void)pauseOrPlayView:(SBPauseOrPlayView *)pauseOrPlayView withState:(BOOL)state;

-(void)fastGoAction:(SBPauseOrPlayView *)pauseOrPlayView;

-(void)fastBackAction:(SBPauseOrPlayView *)pauseOrPlayView;

@end
@interface SBPauseOrPlayView : UIView
@property (nonatomic,strong) UIButton *imageBtn;
@property (nonatomic,strong) UIButton *fastGoBtn;
@property (nonatomic,strong) UIButton *fastBackBtn;
@property (nonatomic,weak) id<SBPauseOrPlayViewDelegate> delegate;
@property (nonatomic,assign,readonly) BOOL state;

@end
