//
//  DentistPlayVC.m
//  DentistProject
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "DentistPlayVC.h"
#import <AVKit/AVKit.h>

@interface DentistPlayVC ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation DentistPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationItem *item = [self navigationItem];
    item.title = @"下载测试";
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self creatControl];
}

- (void)creatControl
{
    // 进度条
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 400, SCREENWIDTH - 20, 50)];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    // 创建播放器
    _player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:_model.localPath]]];

    // 创建显示的图层
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = CGRectMake(0, 0, SCREENWIDTH, 400);
    [self.view.layer addSublayer:playerLayer];

    // 播放视频
    [_player play];
    
    // 进度回调
    WeakSelf
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        StrongSelf
        // 刷新slider
        slider.value = CMTimeGetSeconds(time) / CMTimeGetSeconds(strongSelf.player.currentItem.duration);
    }];
}

- (void)sliderValueChanged:(UISlider *)slider
{
    // 计算时间
    float time = slider.value * CMTimeGetSeconds(_player.currentItem.duration);
    
    // 跳转到指定时间
    [_player seekToTime:CMTimeMake(time, 1.0)];
}

@end
