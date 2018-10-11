//
//  DownloadsItemView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@class Article;
@class RMDownloadIndicator;
@interface DownloadsItemView : UIView
@property (strong, nonatomic)UIButton *markButton;
@property (strong, nonatomic) RMDownloadIndicator *closedIndicator;
/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
/* AFURLSessionManager */
@property (nonatomic, strong) AFURLSessionManager *manager;
/* progress:进度 */
@property (nonatomic, assign) CGFloat progress;
@property (assign, nonatomic)CGFloat downloadedBytes;
-(void) bind:(Article*)item ;
@end
