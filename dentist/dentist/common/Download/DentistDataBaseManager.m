//
//  DentistDataBaseManager.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DentistDataBaseManager.h"
#import "FMDB.h"
#import "NSString+myextend.h"
#import "DetailModel.h"
#import "CMSModel.h"

@interface DentistDataBaseManager ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation DentistDataBaseManager
+ (instancetype)shareManager
{
    static DentistDataBaseManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self creatCMSCachesTable];
    }
    
    return self;
}

// 创表
- (void)creatCMSCachesTable
{
    // 数据库文件路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CMSCaches.sqlite"];
    
    // 创建队列对象，内部会自动创建一个数据库, 并且自动打开
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        // 创表
//        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_CMSCaches (id VARCHAR(100) PRIMARY KEY, email VARCHAR(100),title text,content text,authorId VARCHAR(100),contentTypeId VARCHAR(100),categoryId VARCHAR(100),sponsorId VARCHAR(100),authorPhotoUrl text,author blob,contentTypeName text,categoryName text,sponsorName text, createdate timestamp not null default CURRENT_TIMESTAMP"];
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_CMSCaches (id VARCHAR(100) PRIMARY KEY,title text,featuredMediaId VARCHAR(100),contentTypeId VARCHAR(100),categoryId VARCHAR(100),contentTypeName VARCHAR(100),categoryName VARCHAR(100), jsontext text,downstatus INTEGER default 0, createdate timestamp not null default CURRENT_TIMESTAMP)"];
        if (result) {
        }else {
            NSLog(@"缓存数据表创建失败");
        }
    }];
}

-(void)queryCMSCachesList:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed
{
    NSInteger limit=20;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet;
        resultSet = [db executeQuery:@"SELECT * FROM t_CMSCaches order by createdate desc limit ? offset ?",[NSNumber numberWithInteger:limit],[NSNumber numberWithInteger:skip]];
        NSMutableArray *tmpArr = [NSMutableArray array];
        while ([resultSet next]) {
            CMSModel *model = [[CMSModel alloc] init];
            model.id=[resultSet objectForColumn:@"id"];
            model.featuredMediaId=[resultSet objectForColumn:@"featuredMediaId"];
            model.contentTypeId=[resultSet objectForColumn:@"contentTypeId"];
            model.categoryId=[resultSet objectForColumn:@"categoryId"];
            model.contentTypeName=[resultSet objectForColumn:@"contentTypeName"];
            model.categoryName=[resultSet objectForColumn:@"categoryName"];
            model.title=[resultSet objectForColumn:@"title"];
            model.downstatus=[NSString stringWithFormat:@"%@",@([resultSet intForColumn:@"downstatus"])];
            [tmpArr addObject:model];
        }
        if (completed) {
            completed(tmpArr);
        }
    }];
}

// 插入数据
- (void)insertCMSModel:(CMSModel *)cmsmodel completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:cmsmodel.id]) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            if ([self CheckIsHasDown:db articleid:cmsmodel.id]) {
                if (completed) {
                    completed(YES);
                }
            }else{
                BOOL result = [db executeUpdate:@"INSERT INTO t_CMSCaches (id,title, featuredMediaId,contentTypeId,categoryId,contentTypeName,categoryName,downstatus) VALUES (?,?, ?, ?, ?, ?, ?,?)", cmsmodel.id,cmsmodel.title,cmsmodel.featuredMediaId,cmsmodel.contentTypeId,cmsmodel.categoryId,cmsmodel.contentTypeName,cmsmodel.categoryName,[NSNumber numberWithInteger:1]];
                if (completed) {
                    completed(result);
                }
                if (result) {
                }else {
                    NSLog(@"插入cms失败");
                }
            }
            
        }];
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

// 插入数据
- (void)insertCMS:(NSString *)articleid jsontext:(NSString *)jsontext completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:articleid] && ![NSString isBlankString:jsontext]) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            BOOL result = [db executeUpdate:@"INSERT INTO t_CMSCaches (id, jsontext) VALUES (?, ?)", articleid,jsontext];
            if (completed) {
                completed(result);
            }
            if (result) {
            }else {
                NSLog(@"插入cms失败");
            }
        }];
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

// 更新数据
- (void)updateCMS:(NSString *)articleid jsontext:(NSString *)jsontext completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:articleid] && ![NSString isBlankString:jsontext]) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            BOOL result = [db executeUpdate:@"UPDATE t_CMSCaches set jsontext =?,downstatus=5 where id=? ", jsontext,articleid];
            if (completed) {
                completed(result);
            }
            if (result) {
                [self postStateChangeNotificationWithDatabase:db articleid:articleid status:5];
            }else {
                NSLog(@"更新cms失败");
            }
        }];
    }else{
        if (completed) {
            completed(NO);
        }
    }
    
}

-(BOOL)CheckIsHasDown:(FMDatabase *)db articleid :(NSString *)articleid
{
    NSInteger status = [db intForQuery:@"SELECT 1 FROM t_CMSCaches WHERE id = ?", articleid];
    if (status==1) {
        return YES;
    }else{
        return NO;
    }
}

-(void)CheckIsDowned:(CMSModel *)model completed:(void(^)(NSInteger isdown))completed
{
    if (model) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSInteger status = [db intForQuery:@"SELECT 1 FROM t_CMSCaches WHERE id = ?", model.id];
            if (completed) {
                completed(status);
            }
        }];
    }else{
        if (completed) {
            completed(0);
        }
    }
}

// 状态变更通知
- (void)postStateChangeNotificationWithDatabase:(FMDatabase *)db articleid :(NSString *)articleid status:(NSInteger)status
{
    FMResultSet *resultSet=[db executeQuery:@"SELECT * FROM t_CMSCaches WHERE id = ?", articleid];
    CMSModel *model = [[CMSModel alloc] init];
    while ([resultSet next]) {
        model.id=[resultSet objectForColumn:@"id"];
        model.featuredMediaId=[resultSet objectForColumn:@"featuredMediaId"];
        model.contentTypeId=[resultSet objectForColumn:@"contentTypeId"];
        model.categoryId=[resultSet objectForColumn:@"categoryId"];
        model.contentTypeName=[resultSet objectForColumn:@"contentTypeName"];
        model.categoryName=[resultSet objectForColumn:@"categoryName"];
        model.title=[resultSet objectForColumn:@"title"];
    }
    model.downstatus=[NSString stringWithFormat:@"%@",@(status)];
    // 状态变更通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DetinstDownloadStateChangeNotification" object:model];
}

// 更新数据
- (void)deleteCMS:(NSString *)articleid completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:articleid]) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            BOOL result = [db executeUpdate:@"delete from t_CMSCaches where id= ? ",articleid];
            if (completed) {
                completed(result);
            }
            if (result) {
            }else {
                NSLog(@"删除cms失败");
            }
        }];
    }else{
        if (completed) {
            completed(NO);
        }
    }
    
}


@end
