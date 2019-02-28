//
//  DetinstDownloadModel.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
// 用于修复iOS 10.0、10.1系统暂停后继续下载错误问题

#import <Foundation/Foundation.h>

@interface NSURLSession (CorrectedResumeData)

- (NSURLSessionDownloadTask *)downloadTaskWithCorrectResumeData:(NSData *)resumeData;

@end
