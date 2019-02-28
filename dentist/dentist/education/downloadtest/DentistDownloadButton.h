//
//  DentistDownloadButton.h
//  DentistProject
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DentistDownload.h"

@interface DentistDownloadButton : UIView

@property (nonatomic, strong) DentistDownloadModel *model;  // 数据模型
@property (nonatomic, assign) DentistDownloadState state;   // 下载状态
@property (nonatomic, assign) CGFloat progress;        // 下载进度

// 添加点击方法
- (void)addTarget:(id)target action:(SEL)action;

@end

