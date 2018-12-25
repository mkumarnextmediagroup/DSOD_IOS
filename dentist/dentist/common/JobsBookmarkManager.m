//
//  JobsBookmarkManager.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/25.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "JobsBookmarkManager.h"

@implementation JobsBookmarkManager
+ (instancetype)shareManager
{
    static JobsBookmarkManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _deleteArr =[NSMutableArray array];
        _applyArr=[NSMutableArray array];
    }
    
    return self;
}

-(void)adddeleteBookmark:(NSString *)email postid:(NSString *)postid
{
    NSString *keyvalue=[NSString stringWithFormat:@"%@_%@",email,postid];
    if (![_deleteArr containsObject:keyvalue]) {
        [_deleteArr addObject:keyvalue];
    }
}

-(void)removedeleteBookmark:(NSString *)email postid:(NSString *)postid
{
    NSString *keyvalue=[NSString stringWithFormat:@"%@_%@",email,postid];
    [_deleteArr removeObject:keyvalue];
}

-(BOOL)checkIsDeleteBookmark:(NSString *)email postid:(NSString *)postid
{
    NSString *keyvalue=[NSString stringWithFormat:@"%@_%@",email,postid];
    return [_deleteArr containsObject:keyvalue];
}

-(void)addapplyBookmark:(NSString *)email postid:(NSString *)postid
{
    NSString *keyvalue=[NSString stringWithFormat:@"%@_%@",email,postid];
    if (![_applyArr containsObject:keyvalue]) {
        [_applyArr addObject:keyvalue];
    }
}

-(BOOL)checkIsApplyBookmark:(NSString *)email postid:(NSString *)postid
{
    NSString *keyvalue=[NSString stringWithFormat:@"%@_%@",email,postid];
    return [_applyArr containsObject:keyvalue];
}
@end
