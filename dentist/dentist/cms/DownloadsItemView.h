//
//  DownloadsItemView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "ArticleItemViewDelegate.h"
#import "AFURLSessionManager.h"
@class Article;
@class RMDownloadIndicator;
@class CMSModel;
@interface DownloadsItemView : UIView
@property (strong, nonatomic)UIButton *markButton;
@property (nonatomic,weak) id<ArticleItemViewDelegate>delegate;
@property (strong, nonatomic) CMSModel *cmsmodel;
@property (strong, nonatomic) RMDownloadIndicator *closedIndicator;
/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
/* AFURLSessionManager */
@property (nonatomic, strong) AFURLSessionManager *manager;
/* progress:进度 */
@property (nonatomic, assign) CGFloat progress;
@property (assign, nonatomic)CGFloat downloadedBytes;
-(void) bind:(Article*)item ;
-(void) bindCMS:(CMSModel*)item;
-(AFURLSessionManager *)manager;
-(void)updateProgressView:(CGFloat)val;
-(void)moreAction:(UIButton *)sender;
@end
