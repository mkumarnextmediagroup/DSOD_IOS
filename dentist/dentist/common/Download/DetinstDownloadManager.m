//
//  DetinstDownloadManager.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DetinstDownloadManager.h"
#import "Proto.h"
#import "NSString+myextend.h"
#import "DetailModel.h"
#import "CMSModel.h"

@implementation DetinstDownloadManager
+ (instancetype)shareManager
{
    static DetinstDownloadManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

-(void)startDownLoadCMSModel:(CMSModel *)cmsmodel addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:cmsmodel.id]) {
        [[DentistDataBaseManager shareManager] insertCMSModel:cmsmodel completed:^(BOOL result) {
            //添加数据成功
            if (addCompletion) {
                addCompletion(result);
            }
            if (result) {
                [Proto queryForDetailPage:cmsmodel.id completed:^(BOOL result, NSString *jsontext) {
                    if (result) {
                        [[DentistDataBaseManager shareManager] updateCMS:cmsmodel.id jsontext:jsontext completed:^(BOOL result) {
                            if (completed) {
                                completed(result);
                            }
                        }];
                    }else{
                        if (completed) {
                            completed(NO);
                        }
                    }
                }];
            }else{
                if (completed) {
                    completed(NO);
                }
            }
        }];
       
    }else{
        if (addCompletion) {
            addCompletion(NO);
        }
    }
    
}

@end
