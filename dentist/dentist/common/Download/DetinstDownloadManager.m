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
#import "MagazineModel.h"
#import "DetailModel.h"
#import "Json.h"
#import "JSONModel+myextend.h"

@interface DetinstDownloadManager ()

@property (nonatomic, strong) NSMutableDictionary *dataTaskDic;  //
@property (nonatomic, assign) NSInteger currentCount;            // 当前正在下载的个数
@property (nonatomic, assign) NSInteger maxConcurrentCount;      // 最大同时下载数量

@end
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
        // 初始化
        _currentCount = 0;
        _maxConcurrentCount=5;
        _cancelUniteArray=[NSMutableArray array];
    }
    
    return self;
}

-(void)startDownLoadCMSModel:(CMSModel *)cmsmodel addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:cmsmodel.id]) {
        self->_maxConcurrentCount++;
        [[DentistDataBaseManager shareManager] insertCMSModel:cmsmodel completed:^(BOOL result) {
            //添加数据成功
            if (addCompletion) {
                addCompletion(result);
            }
            if (result) {
                [Proto queryForDetailPage:cmsmodel.id completed:^(BOOL result, NSString *jsontext) {
                    if (result) {
                        [[DentistDataBaseManager shareManager] updateCMS:cmsmodel.id jsontext:jsontext completed:^(BOOL result) {
                            self->_maxConcurrentCount--;
                            if (completed) {
                                completed(result);
                            }
                        }];
                    }else{
                        self->_maxConcurrentCount--;
                        if (completed) {
                            completed(NO);
                        }
                    }
                }];
            }else{
                self->_maxConcurrentCount--;
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

-(void)startDownLoadUniteArticles:(MagazineModel *)model  addCompletion:(void(^)(BOOL result))addCompletion completed:(void(^)(BOOL result))completed
{
    if (model && model._id) {
        const char *downenConstChar=[[NSString stringWithFormat:@"unitedownevent_%@",model._id] UTF8String];
        self->_maxConcurrentCount++;
        [[DentistDataBaseManager shareManager] insertUniteModel:model completed:^(BOOL result) {
            //添加数据成功
            if (result) {
                NSLog(@"====================添加unite数据成功====================");
            }
            if (addCompletion) {
                addCompletion(result);
            }
            if (result) {
                NSArray *arr=model.articles;
//                __block NSInteger downcount=0;
                __block NSMutableArray *jsonarray=[NSMutableArray array];
                dispatch_group_t dispatchGroup = dispatch_group_create();
                for (int i=0; i<arr.count; i++) {
                    NSString *detailid=arr[i];
                    dispatch_group_enter(dispatchGroup);
                    dispatch_group_async(dispatchGroup, dispatch_queue_create(downenConstChar, DISPATCH_QUEUE_CONCURRENT), ^{
                        BOOL iscancel = NO;
                        if (self.cancelUniteArray && self.cancelUniteArray.count>0) {
                            if ([self.cancelUniteArray containsObject:model._id]) {
                                iscancel=YES;
                               
                            }
                        }
                        if (iscancel) {
                             dispatch_group_leave(dispatchGroup);
                        }else{
                            //请求
                            [Proto queryForDetailPage:detailid completed:^(BOOL result, NSString *jsontext) {
                                if (result) {
                                    NSLog(@"====================获取article文章详情成功====================");
                                    if (jsontext) {
                                        [jsonarray addObject:jsontext];
                                    }
                                    dispatch_group_leave(dispatchGroup);
                                    
                                }else{
                                    NSLog(@"====================获取article文章详情失败====================");
                                    dispatch_group_leave(dispatchGroup);
                                }
                                
                            }];
                        }
                        
                    });
                    
                    
                }
                
                dispatch_group_notify(dispatchGroup, dispatch_queue_create(downenConstChar, DISPATCH_QUEUE_CONCURRENT), ^(){
                    BOOL iscancel = NO;
                    if (self.cancelUniteArray && self.cancelUniteArray.count>0) {
                        if ([self.cancelUniteArray containsObject:model._id]) {
                            iscancel=YES;
                            
                        }
                    }
                    if (iscancel) {
                        [self.cancelUniteArray removeObject:model._id];
                        if(completed){
                            completed(NO);
                        }
                    }else{
                        //处理完成更新列表详细信息
                        if (arr.count==jsonarray.count) {
                            
                            //下载完成更新下载状态
                            [[DentistDataBaseManager shareManager] insertUniteArticleArray:model jsonarray:jsonarray completed:^(BOOL result) {
                                self->_maxConcurrentCount--;
                                if(completed){
                                    completed(YES);
                                }
                            }];
                            
                        }else{
                            self->_maxConcurrentCount--;
                            //下载失败
                            if(completed){
                                completed(NO);
                            }
                        }
                    }
                    
                });
                
            }
        }];
    }
}

-(void)cancelDownloadUnite:(MagazineModel *)model
{
    if (![_cancelUniteArray containsObject:model._id]) {
        [_cancelUniteArray addObject:model._id];
        
    }
}


@end
