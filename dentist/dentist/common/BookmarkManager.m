//
//  BookmarkManager.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/27.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "BookmarkManager.h"

@implementation BookmarkManager
+ (instancetype)shareManager
{
    static BookmarkManager *manager = nil;
    
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

@end
