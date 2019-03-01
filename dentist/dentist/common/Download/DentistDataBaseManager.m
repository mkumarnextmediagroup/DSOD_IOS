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
#import "DetailModel.h"
#import "JSONModel+myextend.h"
#import "Article.h"
#import "ArticleComment.h"
#import "DiscussInfo.h"
#import "Json.h"
#import "Proto.h"
#import "IdName.h"
#import "MagazineModel.h"
#import "NSDate+customed.h"
#import "DentistDownloadModel.h"

//NSString * const DentistDownloadStateChangeNotification    = @"DentistDownloadStateChangeNotification";
//NSString * const DentistUniteDownloadStateChangeNotification = @"DentistUniteDownloadStateChangeNotification";
//NSString * const DentistUniteArchiveChangeNotification = @"DentistUniteArchiveChangeNotification";

typedef NS_ENUM(NSInteger, DentistDBGetDateOption) {
    DentistDBGetDateOptionAllCacheData = 0,      // 所有缓存数据
    DentistDBGetDateOptionAllDownloadingData,    // 所有正在下载的数据
    DentistDBGetDateOptionAllDownloadedData,     // 所有下载完成的数据
    DentistDBGetDateOptionAllUnDownloadedData,   // 所有未下载完成的数据
    DentistDBGetDateOptionAllWaitingData,        // 所有等待下载的数据
    DentistDBGetDateOptionModelWithUrl,          // 通过url获取单条数据
    DentistDBGetDateOptionWaitingModel,          // 第一条等待的数据
    DentistDBGetDateOptionLastDownloadingModel,  // 最后一条正在下载的数据
};
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
        [self CMSCachesTable];
    }
    
    return self;
}

-(NSString *)getTableFilePath
{
    // 数据库文件路径NSCachesDirectory/NSDocumentDirectory
    //先保存在Document下面方便导出来，后台改成Caches里面
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CMSCaches.sqlite"];
    return path;
}

// 创表
- (void)CMSCachesTable
{
    
    // 创建队列对象，内部会自动创建一个数据库, 并且自动打开
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[self getTableFilePath]];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        // 创表
//        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_CMSCaches (id VARCHAR(100) PRIMARY KEY, email VARCHAR(100),title text,content text,authorId VARCHAR(100),contentTypeId VARCHAR(100),categoryId VARCHAR(100),sponsorId VARCHAR(100),authorPhotoUrl text,author blob,contentTypeName text,categoryName text,sponsorName text, createdate timestamp not null default CURRENT_TIMESTAMP"];
        [self creatCMSCachesTable:db];
        [self createCMSContentCachesTable:db];
        [self creatUniteCachesTable:db];
        [self creatUniteArticlesCachesTable:db];
        [self createUniteArticlesRelationTable:db];
        [self createCareersJobsLookCachesTable:db];
        [self creatDownloadFileCachesTable:db];
    }];
}

-(void)creatCMSCachesTable:(FMDatabase *)db
{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_CMSCaches (id VARCHAR(100) PRIMARY KEY,title text,featuredMediaId VARCHAR(100),contentTypeId VARCHAR(100),categoryId VARCHAR(100),contentTypeName VARCHAR(100),categoryName VARCHAR(100), jsontext text,downstatus INTEGER default 0, createdate timestamp not null default CURRENT_TIMESTAMP)"];
    if (result) {
        NSLog(@"缓存t_CMSCaches数据表创建成功");
    }else {
        NSLog(@"缓存t_CMSCaches数据表创建失败");
    }
}

-(void)createCMSContentCachesTable:(FMDatabase *)db {
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_CMSContentCaches (id VARCHAR(100) PRIMARY KEY, jsontext text)"];
    if (result) {
        NSLog(@"缓存t_CMSContentCaches数据表创建成功");
    }else {
        NSLog(@"缓存t_CMSContentCaches数据表创建失败");
    }
}

-(void)queryDetailCmsCaches:(NSString *)articleid completed:(void(^)(DetailModel *model))completed
{
    __block DetailModel *detail;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            
            NSString *jsontext = [db stringForQuery:@"SELECT jsontext FROM t_CMSCaches WHERE id = ?", articleid];
            detail = [[DetailModel alloc] initWithJson:jsontext];
            detail.discussInfos = [self commentConvertDiscussInfo:detail.comment];
        }];
        if (completed) {
            completed(detail);
        }
    });
   
}

-(NSArray*)commentConvertDiscussInfo : (NSArray*) comments{
    NSMutableArray *discussInfos = nil;
    if(comments!=nil && comments.count >0){
        discussInfos=[NSMutableArray arrayWithCapacity:comments.count];
        for (int i = 0; i<comments.count; i++) {
            CommentModel *item = [[CommentModel alloc] initWithJson:jsonBuild(comments[i])];
            DiscussInfo *info = [[DiscussInfo alloc] init];
            info.name = item.fullName;
            info.content = item.comment_text;
            info.disDate = item.create_time;
            info.starCount = item.comment_rating;
            info.disImg = [NSString stringWithFormat:@"%@photoDownloadByEmail?email=%@",[Proto configUrl:@"profile"],info.name];
            
            [discussInfos addObject:info ];
        }
    }
    return discussInfos;
}

-(void)queryCMSCachesList:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed
{
    NSInteger limit=20;
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *resultSet;
            resultSet = [db executeQuery:@"SELECT * FROM t_CMSCaches order by createdate desc limit ? offset ?",[NSNumber numberWithInteger:limit],[NSNumber numberWithInteger:skip]];
            
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
        }];
        if (completed) {
            completed(tmpArr);
        }
    });
    
    
}

-(void)queryCMSCachesList:(NSString *)categoryId contentTypeId:(NSString *)contentTypeId skip:(NSInteger)skip completed:(void(^)(NSArray<CMSModel *> *array))completed
{
    NSInteger limit=20;
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *resultSet;
            if(![NSString isBlankString:categoryId] && ![NSString isBlankString:contentTypeId]){
                resultSet = [db executeQuery:@"SELECT * FROM t_CMSCaches where categoryId = ? and contentTypeId = ? order by createdate desc limit ? offset ?",categoryId,contentTypeId,[NSNumber numberWithInteger:limit],[NSNumber numberWithInteger:skip]];
            }else if (![NSString isBlankString:categoryId] && [NSString isBlankString:contentTypeId] ){
                resultSet = [db executeQuery:@"SELECT * FROM t_CMSCaches  where categoryId = ? order by createdate desc limit ? offset ?",categoryId,[NSNumber numberWithInteger:limit],[NSNumber numberWithInteger:skip]];
            }else if ([NSString isBlankString:categoryId] && ![NSString isBlankString:contentTypeId] ){
                resultSet = [db executeQuery:@"SELECT * FROM t_CMSCaches  where contentTypeId = ? order by createdate desc limit ? offset ?",contentTypeId,[NSNumber numberWithInteger:limit],[NSNumber numberWithInteger:skip]];
            }else{
                resultSet = [db executeQuery:@"SELECT * FROM t_CMSCaches order by createdate desc limit ? offset ?",[NSNumber numberWithInteger:limit],[NSNumber numberWithInteger:skip]];
            }
            
            
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
        }];
        if (completed) {
            completed(tmpArr);
        }
    });
    
    
}

// 插入数据
- (void)insertCMSModel:(CMSModel *)cmsmodel  completed:(void(^)(BOOL result))completed
{
    
    if (![NSString isBlankString:cmsmodel.id]) {
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                if ([self CheckIsHasDown:db articleid:cmsmodel.id]) {
                    
                    result=YES;
                }else{
                    NSString* type = cmsmodel.featuredMedia[@"type"];
                    NSString *urlstr;
                    if([type isEqualToString:@"1"] ){
                        //pic
                        NSDictionary *codeDic = cmsmodel.featuredMedia[@"code"];
                        urlstr = codeDic[@"thumbnailUrl"];
                    }else{
                        urlstr = cmsmodel.featuredMedia[@"code"];
                    }
                    result = [db executeUpdate:@"INSERT INTO t_CMSCaches (id,title, featuredMediaId,contentTypeId,categoryId,contentTypeName,categoryName,downstatus) VALUES (?,?, ?, ?, ?, ?, ?,?)", cmsmodel.id,cmsmodel.title,urlstr,cmsmodel.contentTypeId,cmsmodel.categoryId,cmsmodel.contentTypeName,cmsmodel.categoryName,[NSNumber numberWithInteger:1]];
                    
                    if (result) {
                    }else {
                        NSLog(@"插入cms失败");
                    }
                }
                
            }];
            if (completed) {
                completed(result);
            }
        });
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
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                result = [db executeUpdate:@"INSERT INTO t_CMSCaches (id, jsontext) VALUES (?, ?)", articleid,jsontext];
                if (result) {
                }else {
                    NSLog(@"插入cms失败");
                }
            }];
            if (completed) {
                completed(result);
            }
        });
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
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                result = [db executeUpdate:@"UPDATE t_CMSCaches set jsontext =?,downstatus=5 where id=? ", jsontext,articleid];
                if (result) {
                    [self postStateChangeNotificationWithDatabase:db articleid:articleid status:5];
                }else {
                    NSLog(@"更新cms失败");
                }
                
            }];
            if (completed) {
                completed(result);
            }
        });
        
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
        __block NSInteger status;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                status = [db intForQuery:@"SELECT 1 FROM t_CMSCaches WHERE id = ?", model.id];
            }];
            if (completed) {
                completed(status);
            }
        });
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
    [[NSNotificationCenter defaultCenter] postNotificationName:DentistDownloadStateChangeNotification object:model];
}

// 更新数据
- (void)deleteCMS:(NSString *)articleid completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:articleid]) {
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                result = [db executeUpdate:@"delete from t_CMSCaches where id= ? ",articleid];
                if (result) {
                }else {
                    NSLog(@"删除cms失败");
                }
            }];
            if (completed) {
                completed(result);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
    
    
    
}

#pragma mark -------缓存接口返回数据
//MARK: 更新数据缓存记录
-(void)updateContentCaches:(NSString *)key jsontext:(NSString *)jsontext completed:(void (^)(BOOL result))completed{
    __block BOOL result;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            NSInteger status = [db intForQuery:@"SELECT 1 FROM t_CMSContentCaches WHERE id = ?", key];
            if (status==1) {
                //存在该记录更新
                result = [db executeUpdate:@"UPDATE t_CMSContentCaches set jsontext =? where id=? ", jsontext,key];
            }else{
                //添加
                result = [db executeUpdate:@"INSERT INTO t_CMSContentCaches (id, jsontext) VALUES (?, ?)", key,jsontext];
                
            }
        }];
        if (completed) {
            completed(result);
        }
    });
    
}

//MARK: 获取媒体列表缓存数据
-(void)queryAllContentsCaches:(NSString *)key completed:(void (^)(NSArray<CMSModel *> *array))completed
{
    __block NSMutableArray *resultArray = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *jsontext = [db stringForQuery:@"SELECT jsontext FROM t_CMSContentCaches WHERE id = ?", key];
            NSArray *arr = jsonParseObject(jsontext);
            
            for (NSDictionary *d in arr) {
                CMSModel *item = [[CMSModel alloc] initWithJson:jsonBuild(d)];
                item.isBookmark=NO;
                if (item) {
                    [resultArray addObject:item];
                }
            }
        }];
        if (completed) {
            completed(resultArray);
        }
    });
    
}

-(void)queryContentsCaches:(NSString *)key completed:(void (^)(NSArray *array))completed
{
    __block NSArray *arr;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *jsontext = [db stringForQuery:@"SELECT jsontext FROM t_CMSContentCaches WHERE id = ?", key];
            arr = jsonParseObject(jsontext);
            
        }];
        if (completed) {
            completed(arr);
        }
    });
    
}

-(void)queryContentTypesCaches:(void(^)(NSArray<IdName *> *array))completed {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block NSMutableArray *resultArray = [NSMutableArray array];
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *key=@"findAllContentType";
            NSString *jsontext = [db stringForQuery:@"SELECT jsontext FROM t_CMSContentCaches WHERE id = ?", key];
            NSArray *arr = jsonParseObject(jsontext);
            for (NSDictionary *d in arr) {
                IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
                [resultArray addObject:item];
            }
        }];
        if (completed) {
            completed(resultArray);
        }
    });
    
}

-(void)queryCategoryTypesCaches:(void(^)(NSArray<IdName *> *array))completed {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block NSMutableArray *resultArray = [NSMutableArray array];
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *key=@"findAllCategory";
            NSString *jsontext = [db stringForQuery:@"SELECT jsontext FROM t_CMSContentCaches WHERE id = ?", key];
            NSArray *arr = jsonParseObject(jsontext);
            
            for (NSDictionary *d in arr) {
                IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
                [resultArray addObject:item];
            }
        }];
        if (completed) {
            completed(resultArray);
        }
    });
    
}

#pragma mark ----unite 下载
//MARK:创建unite 杂志表
-(void)creatUniteCachesTable:(FMDatabase *)db
{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_UniteCaches (id VARCHAR(100) PRIMARY KEY,serial text,vol text,publishDate VARCHAR(100),cover text,articles text,createDate VARCHAR(100),createUser text,issue text,jsontext text,downstatus INTEGER default 0,isarchive INTEGER default 0, createtime timestamp not null default CURRENT_TIMESTAMP, downtime timestamp not null default CURRENT_TIMESTAMP)"];
    if (result) {
        NSLog(@"缓存t_UniteCaches数据表创建成功");
    }else {
        NSLog(@"缓存t_UniteCaches数据表创建失败");
    }
}

//MARK:创建uniterticles 杂志文章表
-(void)creatUniteArticlesCachesTable:(FMDatabase *)db
{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_UniteArticlesCaches (id VARCHAR(100) PRIMARY KEY,title text,contentTypeId VARCHAR(100),categoryId VARCHAR(100),contentTypeName VARCHAR(100),categoryName VARCHAR(100), jsontext text,isbookmark INTEGER default 0,downstatus INTEGER default 0, createdate timestamp not null default CURRENT_TIMESTAMP, bookmarktime timestamp not null default CURRENT_TIMESTAMP)"];
    if (result) {
        NSLog(@"缓存t_UniteArticles数据表创建成功");
    }else {
        NSLog(@"缓存t_UniteArticles数据表创建失败");
    }
}

//MARK:创建uniterticles 杂志文章关联表
-(void)createUniteArticlesRelationTable:(FMDatabase *)db{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_UniteArticlesRelationCaches (uniteid VARCHAR(100),articleid VARCHAR(100),sort INTEGER default 0,PRIMARY KEY(uniteid,articleid))"];
    if (result) {
        NSLog(@"缓存t_UniteArticlesRelation数据表创建成功");
    }else {
        NSLog(@"缓存t_UniteArticlesRelation数据表创建失败");
    }
}

//MARK:添加杂志记录
- (void)insertUniteModel:(MagazineModel *)model completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:model._id]) {
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                NSString *_id=[NSString stringWithFormat:@"%@",model._id];
                NSString *serial=[NSString stringWithFormat:@"%@",model.serial];
                NSString *vol=[NSString stringWithFormat:@"%@",model.vol];
                NSString *publishDate=[NSString stringWithFormat:@"%@",model.publishDate];
                NSString *cover=[NSString stringWithFormat:@"%@",model.cover];
                NSString *articles=[NSString stringWithFormat:@"%@",model.articles];
                NSString *createDate=[NSString stringWithFormat:@"%@",model.createDate];
                NSString *createUser=[NSString stringWithFormat:@"%@",model.createUser];
                NSString *issue=[NSString stringWithFormat:@"%@",model.issue];
                if ([self CheckIsHasUnite:db uniteid:model._id]) {
                    //更新
                    result = [db executeUpdate:@"UPDATE t_UniteCaches set serial = ?,vol = ?,publishDate = ?,cover = ?,articles = ?,createDate = ?,createUser = ?,issue = ?,downstatus = ?,isarchive = 0,downstatus=0  where id = ? ", serial,vol,publishDate,cover,articles,createDate,createUser,issue,[NSNumber numberWithInt:1],_id];
                    
                    if (result) {
                    }else {
                        NSLog(@"更新Unite失败");
                    }
                    
                }else{
                    
                    result = [db executeUpdate:@"INSERT INTO t_UniteCaches (id ,serial,vol,publishDate,cover,articles,createDate,createUser,issue,downstatus) VALUES (?,?, ?, ?, ?, ?, ?,?, ?,?)", _id,serial,vol,publishDate,cover,articles,createDate,createUser,issue,[NSNumber numberWithInt:1]];
                    
                    if (result) {
                    }else {
                        NSLog(@"插入cms失败");
                    }
                }
                
                
            }];
            if(result){
                model.downstatus=[NSString stringWithFormat:@"%@",@(1)];
                // 状态变更通知
                [[NSNotificationCenter defaultCenter] postNotificationName:DentistUniteDownloadStateChangeNotification object:model];
            }
            if (completed) {
                completed(result);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

//MARK:更新杂志下载状态，downstatus==0未下载；1，正在下载；2下载成功
-(void)updateUniteDownstatus:(NSString *)uniteid downstatus:(NSInteger)downstatus completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:uniteid]) {
        __block BOOL result = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                result=[db executeUpdate:@"update t_UniteCaches set downstatus = ?,downtime=datetime('now')  where id = ? ",[NSNumber numberWithInteger:downstatus],uniteid];
                
                if (result) {
                    NSLog(@"更新unite下载状态成功");
                }else {
                    NSLog(@"更新unite下载状态失败");
                }
            }];
            if (completed) {
                completed(result);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

//MARK:archive 删除下载的杂志文章 ，除了已收藏的杂志文章
-(void)archiveUnite:(NSString *)uniteid completed:(void(^)(BOOL result))completed
{
    __block BOOL result=YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            @try {
                [db executeUpdate:@"DELETE FROM t_UniteArticlesCaches where id in (select articleid from t_UniteArticlesRelationCaches where uniteid = ? and articleid in (select articleid from t_UniteArticlesRelationCaches  group by articleid having count(articleid)== 1) ) and isbookmark=0 ", uniteid];
                [db executeUpdate:@"DELETE FROM t_UniteArticlesRelationCaches where uniteid = ? and articleid in (select a.articleid from t_UniteArticlesRelationCaches as a left join t_UniteArticlesCaches as b  where a.uniteid=? and b.isbookmark=0) ",uniteid,uniteid];
                [db executeUpdate:@"update t_UniteCaches set isarchive=1,downstatus=0 where id=? ", uniteid];
            } @catch (NSException *exception) {
                result = NO;
                // 事务回退
                [db rollback];
            } @finally {
                if (result) {
                    //事务提交
                    [db commit];
                }
            }
            
            if (result) {
                NSLog(@"更新unite下载状态成功");
            }else {
                NSLog(@"更新unite下载状态失败");
            }
        }];
        if(result){
            // 状态变更通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DentistUniteArchiveChangeNotification object:uniteid];
        }
        if (completed) {
            completed(result);
        }
    });
}

//unite 下载
-(void)insertUniteArticleArray:(MagazineModel *)model jsonarray:(NSArray *)jsonarray completed:(void(^)(BOOL result))completed
{
    __block BOOL result=YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            @try {
                //先插入unite文章列表
                NSString *_id=[NSString stringWithFormat:@"%@",model._id];
                NSString *serial=[NSString stringWithFormat:@"%@",model.serial];
                NSString *vol=[NSString stringWithFormat:@"%@",model.vol];
                NSString *publishDate=[NSString stringWithFormat:@"%@",model.publishDate];
                NSString *cover=[NSString stringWithFormat:@"%@",model.cover];
                NSString *articles=[NSString stringWithFormat:@"%@",model.articles];
                NSString *createDate=[NSString stringWithFormat:@"%@",model.createDate];
                NSString *createUser=[NSString stringWithFormat:@"%@",model.createUser];
                NSString *issue=[NSString stringWithFormat:@"%@",model.issue];
                if ([self CheckIsHasUnite:db uniteid:model._id]) {
                    //更新
                    [db executeUpdate:@"UPDATE t_UniteCaches set serial = ?,vol = ?,publishDate = ?,cover = ?,articles = ?,createDate = ?,createUser = ?,issue = ?,downstatus = ? where id = ? ", serial,vol,publishDate,cover,articles,createDate,createUser,issue,[NSNumber numberWithInt:2],_id];
                    
                }else{
                    
                    [db executeUpdate:@"INSERT INTO t_UniteCaches (id ,serial,vol,publishDate,cover,articles,createDate,createUser,issue,downstatus) VALUES (?,?, ?, ?, ?, ?, ?,?, ?)", _id,serial,vol,publishDate,cover,articles,createDate,createUser,issue,[NSNumber numberWithInt:2]];
                }
                
                //插入杂志文章还有杂志文章关系
                for (NSString *jsontext in jsonarray) {
                    DetailModel *detailmodel = [[DetailModel alloc] initWithJson:jsontext];
                    NSInteger sort=[model.articles indexOfObject:detailmodel.id];
                    if ([self CheckIsHasUniteArticle:db articleid:detailmodel.id]) {
                        //更新
                        [db executeUpdate:@"UPDATE t_UniteArticlesCaches set title = ?,contentTypeId = ?,categoryId = ?,contentTypeName = ?,categoryName = ?,jsontext = ? where id = ? ",detailmodel.title,detailmodel.contentTypeId,detailmodel.categoryId,detailmodel.contentTypeName,detailmodel.categoryName,jsontext,detailmodel.id];
                        
                    }else{
                        [db executeUpdate:@"INSERT INTO t_UniteArticlesCaches (id,title,contentTypeId,categoryId ,contentTypeName ,categoryName, jsontext) VALUES (?, ?, ?, ?, ?, ?,?)", detailmodel.id,detailmodel.title,detailmodel.contentTypeId,detailmodel.categoryId,detailmodel.contentTypeName,detailmodel.categoryName,jsontext];
                    }
                    
                    if ([self CheckIsHasUniteArticleRelation:db uniteid:model._id articleid:detailmodel.id]) {
                        //更新
                        [db executeUpdate:@"UPDATE t_UniteArticlesRelationCaches set sort = ? where uniteid = ? and articleid = ?",[NSNumber numberWithInteger:sort],model._id,detailmodel.id];
                        
                    }else{
                        result = [db executeUpdate:@"INSERT INTO t_UniteArticlesRelationCaches (uniteid,articleid,sort) VALUES (?, ?, ?)", model._id,detailmodel.id,[NSNumber numberWithInteger:sort]];
                    }
                }
                
            } @catch (NSException *exception) {
                result = NO;
                // 事务回退
                [db rollback];
            } @finally {
                if (result) {
                    //事务提交
                    [db commit];
                }
            }
            
            if (result) {
                NSLog(@"更新unite下载状态成功");
            }else {
                NSLog(@"更新unite下载状态失败");
            }
        }];
        if (result) {
            model.downstatus=[NSString stringWithFormat:@"%@",@(2)];
            // 状态变更通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DentistUniteDownloadStateChangeNotification object:model];
        }
        if (completed) {
            completed(result);
        }
    });
}

-(BOOL)CheckIsHasUnite:(FMDatabase *)db uniteid:(NSString *)uniteid
{
    NSInteger status = [db intForQuery:@"SELECT 1 FROM t_UniteCaches WHERE id = ?", uniteid];
    if (status==1) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)CheckIsHasUniteArticle:(FMDatabase *)db articleid:(NSString *)articleid
{
    NSInteger status = [db intForQuery:@"SELECT 1 FROM t_UniteArticlesCaches WHERE id = ?",articleid];
    if (status==1) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)CheckIsHasUniteArticleRelation:(FMDatabase *)db uniteid:(NSString *)uniteid articleid:(NSString *)articleid
{
    NSInteger status = [db intForQuery:@"SELECT 1 FROM t_UniteArticlesRelationCaches WHERE uniteid = ? and articleid = ?",uniteid,articleid];
    if (status==1) {
        return YES;
    }else{
        return NO;
    }
}

//MARK:获取已下载的杂志列表
-(void)queryUniteDownloadedList:(void(^)(NSArray<MagazineModel *> *array))completed
{
    __block NSMutableArray *resultArray = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *resultSet;
            resultSet  = [db executeQuery:@"SELECT * FROM t_UniteCaches WHERE downstatus =2 and isarchive = 0 order by downtime desc "];
            while ([resultSet next]) {
                NSString *_id=[resultSet objectForColumn:@"id"];
                NSString *serial=[resultSet objectForColumn:@"serial"];
                NSString *vol=[resultSet objectForColumn:@"vol"];
                NSString *publishDate=[resultSet objectForColumn:@"publishDate"];
                NSString *cover=[resultSet objectForColumn:@"cover"];
                NSString *createUser=[resultSet objectForColumn:@"createUser"];
                NSString *issue=[resultSet objectForColumn:@"issue"];
                MagazineModel *item = [[MagazineModel alloc] init];
                item._id=_id;
                item.serial=![NSString isBlankString:serial]?serial:@"";
                item.vol=![NSString isBlankString:vol]?vol:@"";
                item.publishDate=![NSString isBlankString:publishDate]?publishDate:@"";
                item.cover=![NSString isBlankString:cover]?cover:@"";
                item.createUser=![NSString isBlankString:createUser]?createUser:@"";
                item.issue=![NSString isBlankString:issue]?issue:@"";
                if (item) {
                    [resultArray addObject:item];
                }
            }
            
        }];
        if (completed) {
            completed(resultArray);
        }
    });
    
}

//MARK:根据杂志ID查询杂志文章列表
-(void)queryUniteArticlesCachesList:(NSString *)uniteid completed:(void(^)(NSArray<DetailModel *> *array))completed
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    if (uniteid) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                FMResultSet *resultSet;
                resultSet = [db executeQuery:@"SELECT a.uniteid,a.articleid,b.title,b.contentTypeId,b.categoryId,b.contentTypeName,b.categoryName , b.jsontext,b.isbookmark,c.serial,c.vol,c.publishDate,c.cover,c.createUser,c.issue  FROM t_UniteArticlesRelationCaches as a left join t_UniteArticlesCaches as b on a.articleid = b.id left join t_UniteCaches as c on a.uniteid = c.id where a.uniteid = ? order by a.sort ",uniteid];
                
                while ([resultSet next]) {
                    NSString *jsontext=[resultSet objectForColumn:@"jsontext"];
                    NSString *newuniteid=[resultSet objectForColumn:@"uniteid"];
                    NSString *serial=[resultSet objectForColumn:@"serial"];
                    NSString *vol=[resultSet objectForColumn:@"vol"];
                    NSString *publishDate=[resultSet objectForColumn:@"publishDate"];
                    NSString *cover=[resultSet objectForColumn:@"cover"];
                    NSString *createUser=[resultSet objectForColumn:@"createUser"];
                    NSString *issue=[resultSet objectForColumn:@"issue"];
                    
                    NSInteger isbookmark=[resultSet intForColumn:@"isbookmark"];
                    
                    if (![NSString isBlankString:jsontext]) {
                        DetailModel *detail = [[DetailModel alloc] initWithJson:jsontext];
                        detail.uniteid=newuniteid;
                        detail.isBookmark=(isbookmark==1)?YES:NO;
                        MagazineModel *magazinemodel=[[MagazineModel alloc] init];
                        magazinemodel.serial=![NSString isBlankString:serial]?serial:@"";
                        magazinemodel.vol=![NSString isBlankString:vol]?vol:@"";
                        magazinemodel.publishDate=![NSString isBlankString:publishDate]?publishDate:@"";
                        magazinemodel.cover=![NSString isBlankString:cover]?cover:@"";
                        magazinemodel.createUser=![NSString isBlankString:createUser]?createUser:@"";
                        magazinemodel.issue=![NSString isBlankString:issue]?issue:@"";
                        detail.magazineModel=magazinemodel;
                        if (detail) {
                            [tmpArr addObject:detail];
                        }
                    }
                }
            }];
            if (completed) {
                completed(tmpArr);
            }
        });
    }else{
        if (completed) {
            completed(tmpArr);
        }
    }
    
}

//MARK:根据杂志ID查询杂志文章列表
-(void)queryUniteArticlesCachesList2:(NSString *)uniteid completed:(void(^)(NSArray<DetailModel *> *array))completed{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    [self queryUniteArticlesCachesList:uniteid completed:^(NSArray<DetailModel *> * _Nonnull array) {
        if (array && array.count>0) {
            tmpArr=[NSMutableArray arrayWithArray:array];
            DetailModel *firstdetail=array[0];
            firstdetail.uniteArticleType=@"2";
            DetailModel *newdetail=[DetailModel new];
            newdetail.id=@"-1";
            newdetail.uniteArticleType=@"1";
            newdetail.magazineModel=firstdetail.magazineModel;
            [tmpArr insertObject:newdetail atIndex:0];
            DetailModel *newdetail2=[DetailModel new];
            newdetail2.id=@"-2";
            newdetail2.uniteArticleType=@"3";
            MagazineModel *newmagazinemodel=[MagazineModel new];
            newmagazinemodel.cover=@"5bfce1f8d6fe17478531c652";
            newmagazinemodel._id=firstdetail.magazineModel._id;
            newmagazinemodel.serial=firstdetail.magazineModel.serial;
            newmagazinemodel.vol=firstdetail.magazineModel.vol;
            newmagazinemodel.issue=firstdetail.magazineModel.issue;
            newmagazinemodel.publishDate=firstdetail.magazineModel.publishDate;
            newmagazinemodel.createDate=firstdetail.magazineModel.createDate;
            newmagazinemodel.articles=firstdetail.magazineModel.articles;
            newmagazinemodel.createDate=firstdetail.magazineModel.createDate;
            newmagazinemodel.createUser=firstdetail.magazineModel.createUser;
            newdetail2.magazineModel=newmagazinemodel;
            [tmpArr insertObject:newdetail2 atIndex:2];
        }
        if (completed) {
            completed(tmpArr);
        }
    }];
}

//MARK:添加删除杂志文章方法，isbookmark==1收藏；0取消收藏
-(void)updateUniteArticleBookmark:(NSString *)articleid isbookmark:(NSInteger)isbookmark completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:articleid]) {
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                result = [db executeUpdate:@"update t_UniteArticlesCaches set isbookmark = ?,bookmarktime=datetime('now')  where id = ? ",[NSNumber numberWithInteger:isbookmark],articleid];
                if (result) {
                }else {
                    NSLog(@"删除cms失败");
                }
            }];
            if (completed) {
                completed(result);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

//MARK:获取已收藏的杂志文章列表
-(void)queryUniteArticlesBookmarkCachesList:(void(^)(NSArray<DetailModel *> *array))completed
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *resultSet;
            resultSet = [db executeQuery:@"SELECT a.uniteid,a.articleid,b.title,b.contentTypeId,b.categoryId,b.contentTypeName,b.categoryName , b.jsontext,b.isbookmark,c.serial,c.vol,c.publishDate,c.cover,c.createUser,c.issue  FROM  t_UniteArticlesCaches as b left join t_UniteArticlesRelationCaches as a  on a.articleid = b.id left join t_UniteCaches as c on a.uniteid = c.id where  b.isbookmark=1 group by a.articleid  order by b.bookmarktime  "];
            
            while ([resultSet next]) {
                NSString *jsontext=[resultSet objectForColumn:@"jsontext"];
                NSString *newuniteid=[resultSet objectForColumn:@"uniteid"];
                NSString *serial=[resultSet objectForColumn:@"serial"];
                NSString *vol=[resultSet objectForColumn:@"vol"];
                NSString *publishDate=[resultSet objectForColumn:@"publishDate"];
                NSString *cover=[resultSet objectForColumn:@"cover"];
                NSString *createUser=[resultSet objectForColumn:@"createUser"];
                NSString *issue=[resultSet objectForColumn:@"issue"];
                
                NSInteger isbookmark=[resultSet intForColumn:@"isbookmark"];
                
                if (![NSString isBlankString:jsontext]) {
                    DetailModel *detail = [[DetailModel alloc] initWithJson:jsontext];
                    detail.uniteid=newuniteid;
                    detail.isBookmark=(isbookmark==1)?YES:NO;
                    MagazineModel *magazinemodel=[[MagazineModel alloc] init];
                    
                    magazinemodel.serial=![NSString isBlankString:serial]?serial:@"";
                    magazinemodel.vol=![NSString isBlankString:vol]?vol:@"";
                    magazinemodel.publishDate=![NSString isBlankString:publishDate]?publishDate:@"";
                    magazinemodel.cover=![NSString isBlankString:cover]?cover:@"";
                    magazinemodel.createUser=![NSString isBlankString:createUser]?createUser:@"";
                    magazinemodel.issue=![NSString isBlankString:issue]?issue:@"";
                    detail.magazineModel=magazinemodel;
                    if (detail) {
                        [tmpArr addObject:detail];
                    }
                }
            }
        }];
        if (completed) {
            completed(tmpArr);
        }
    });
   
}

//MARK:根据关键字查询已收藏的杂志文章列表
-(void)queryUniteArticlesBookmarkCachesList:(NSString *)keywords completed:(void(^)(NSArray<DetailModel *> *array))completed
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *newkeywords=[NSString stringWithFormat:@"%@%@%@",@"%",keywords,@"%"];
            NSString *sqlstr=[NSString stringWithFormat:@"SELECT a.uniteid,a.articleid,b.title,b.contentTypeId,b.categoryId,b.contentTypeName,b.categoryName , b.jsontext,b.isbookmark,c.serial,c.vol,c.publishDate,c.cover,c.createUser,c.issue  FROM  t_UniteArticlesCaches as b left join t_UniteArticlesRelationCaches as a  on a.articleid = b.id left join t_UniteCaches as c on a.uniteid = c.id where  b.isbookmark=1 and b.jsontext like '%@' group by a.articleid  order by b.bookmarktime  ",newkeywords];
            FMResultSet *resultSet;
            resultSet = [db executeQuery:sqlstr];
            
            while ([resultSet next]) {
                NSString *jsontext=[resultSet objectForColumn:@"jsontext"];
                NSString *newuniteid=[resultSet objectForColumn:@"uniteid"];
                NSString *serial=[resultSet objectForColumn:@"serial"];
                NSString *vol=[resultSet objectForColumn:@"vol"];
                NSString *publishDate=[resultSet objectForColumn:@"publishDate"];
                NSString *cover=[resultSet objectForColumn:@"cover"];
                NSString *createUser=[resultSet objectForColumn:@"createUser"];
                NSString *issue=[resultSet objectForColumn:@"issue"];
                
                NSInteger isbookmark=[resultSet intForColumn:@"isbookmark"];
                
                if (![NSString isBlankString:jsontext]) {
                    DetailModel *detail = [[DetailModel alloc] initWithJson:jsontext];
                    detail.uniteid=newuniteid;
                    detail.isBookmark=(isbookmark==1)?YES:NO;
                    MagazineModel *magazinemodel=[[MagazineModel alloc] init];
                    
                    magazinemodel.serial=![NSString isBlankString:serial]?serial:@"";
                    magazinemodel.vol=![NSString isBlankString:vol]?vol:@"";
                    magazinemodel.publishDate=![NSString isBlankString:publishDate]?publishDate:@"";
                    magazinemodel.cover=![NSString isBlankString:cover]?cover:@"";
                    magazinemodel.createUser=![NSString isBlankString:createUser]?createUser:@"";
                    magazinemodel.issue=![NSString isBlankString:issue]?issue:@"";
                    detail.magazineModel=magazinemodel;
                    if (detail) {
                        [tmpArr addObject:detail];
                    }
                }
            }
        }];
        if (completed) {
            completed(tmpArr);
        }
    });
    
}

//MARK:根据keyword搜索文章
-(void)queryUniteArticlesCachesByKeywordList:(NSString *)uniteid keywords:(NSString *)keywords completed:(void(^)(NSArray<DetailModel *> *array))completed
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    if (uniteid) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                NSString *newkeywords=[NSString stringWithFormat:@"%@%@%@",@"%",keywords,@"%"];
                //where title like '%@'
                NSString *sqlstr=[NSString stringWithFormat:@"SELECT a.uniteid,a.articleid,b.title,b.contentTypeId,b.categoryId,b.contentTypeName,b.categoryName , b.jsontext,b.isbookmark FROM t_UniteArticlesRelationCaches as a left join t_UniteArticlesCaches as b on a.articleid = b.id  where a.uniteid = '%@' and b.jsontext like '%@' order by a.sort ",uniteid,newkeywords];
                FMResultSet *resultSet;
                resultSet = [db executeQuery:sqlstr];
                
                while ([resultSet next]) {
                    NSString *jsontext=[resultSet objectForColumn:@"jsontext"];
                    NSString *newuniteid=[resultSet objectForColumn:@"uniteid"];
                    if (![NSString isBlankString:jsontext]) {
                        DetailModel *detail = [[DetailModel alloc] initWithJson:jsontext];
                        detail.uniteid=newuniteid;
                        if (detail) {
                            [tmpArr addObject:detail];
                        }
                    }
                }
            }];
            if (completed) {
                completed(tmpArr);
            }
        });
    }else{
        if (completed) {
            completed(tmpArr);
        }
    }
    
}

//MARK:检查该杂志是否已经下载
-(void)checkUniteStatus:(NSString *)uniteid  completed:(void(^)(NSInteger result))completed
{
    if (![NSString isBlankString:uniteid]) {
        __block NSInteger result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                result =[db intForQuery:@"SELECT downstatus FROM t_UniteCaches WHERE id = ? and isarchive = 0 ", uniteid];;
                if (result) {
                }else {
                }
            }];
            if (completed) {
                completed(result);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

//MARK:创建job查看表
-(void)createCareersJobsLookCachesTable:(FMDatabase *)db {
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_CareersJobsLookCaches (id VARCHAR(100), email VARCHAR(100), looktime timestamp not null default CURRENT_TIMESTAMP,PRIMARY KEY(id,email))"];
    if (result) {
        NSLog(@"缓存t_CareersJobsLookCaches数据表创建成功");
    }else {
        NSLog(@"缓存t_CareersJobsLookCaches数据表创建失败");
    }
}

//MARK:添加更新job查看表
-(void)updateCareersJobs:(NSString *)jobid completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:jobid]) {
        __block BOOL result = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                NSInteger status = [db intForQuery:@"SELECT 1 FROM t_CareersJobsLookCaches WHERE id = ? and email = ?", jobid,getLastAccount()];
                if (status==1) {
                    //存在该记录更新
                    result = [db executeUpdate:@"UPDATE t_CareersJobsLookCaches set looktime=datetime('now')  where id=? and email = ? ",jobid,getLastAccount()];
                }else{
                    //添加
                    result = [db executeUpdate:@"INSERT INTO t_CareersJobsLookCaches (id,email) VALUES (?,?)", jobid,getLastAccount()];
                    
                }
                
                if (result) {
                    NSLog(@"更新t_CareersJobsLookCaches成功");
                }else {
                    NSLog(@"更新t_CareersJobsLookCaches失败");
                }
            }];
            if (completed) {
                completed(result);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

-(void)checkJobsStatus:(NSString *)jobid publishDate:(NSString *)publishDate modifiedDate:(NSString *)modifiedDate completed:(void(^)(NSInteger result))completed
{
    [self checkJobsPublishDateStatus:jobid publishDate:publishDate completed:^(BOOL result) {
        if (result) {
            if (completed) {
                completed(1);
            }
        }else{
            [self checkJobsModifiedDateStatus:jobid modifiedDate:modifiedDate completed:^(BOOL result) {
                if (result) {
                    if (completed) {
                        completed(2);
                    }
                }else{
                    if (completed) {
                        completed(0);
                    }
                }
            }];
        }
        
    }];
    
}

-(void)checkJobsPublishDateStatus:(NSString *)jobid publishDate:(NSString *)publishDate completed:(void(^)(BOOL result))completed{
    
    if ([NSDate compareDatetimeIn30:publishDate]) {
        //30天内，并且没有查看过职位详情的为新工作
        __block BOOL status=NO;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                BOOL ret =[db intForQuery:@"SELECT 1 FROM t_CareersJobsLookCaches WHERE id = ?  and email = ?", jobid,getLastAccount()];;
                if (ret==1) {
                    status=NO;
                }else {
                    status=YES;
                }
            }];
            if (completed) {
                completed(status);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
}

-(void)checkJobsModifiedDateStatus:(NSString *)jobid modifiedDate:(NSString *)modifiedDate completed:(void(^)(BOOL result))completed{
    if ([NSDate compareDatetimeIn30:modifiedDate]) {
        NSString *mdate=[NSDate UTCDateTimeLongFormatWithStringTimestamp:modifiedDate];
        //30天内，该工作职位是否更新了
        __block BOOL status=NO;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                BOOL ret  =[db intForQuery:@"SELECT 1 FROM t_CareersJobsLookCaches WHERE id = ?  and email = ? and strftime('%s',?) -strftime('%s',looktime)<0 ", jobid,getLastAccount(),mdate];
                if (ret==1) {
                    //已查看
                    status=NO;
                }else {
                    status=YES;
                }
            }];
            if (completed) {
                completed(status);
            }
        });
    }else{
        if (completed) {
            completed(NO);
        }
    }
    
    
}

#pragma mark -------网络下载文件表

// 创表
-(void)creatDownloadFileCachesTable:(FMDatabase *)db
{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_downloadfileCaches (id integer PRIMARY KEY AUTOINCREMENT, vid text, fileName text, url text, resumeData blob, totalFileSize integer, tmpFileSize integer, state integer, downloadtype integer, progress float, lastSpeedTime integer, intervalFileSize integer, lastStateTime integer)"];
    if (result) {
        NSLog(@"缓存文件数据表创建成功");
    }else {
        NSLog(@"缓存文件数据表创建失败");
    }
}

// 插入数据
- (void)insertModel:(DentistDownloadModel *)model
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"INSERT INTO t_downloadfileCaches (vid, fileName, url, resumeData, totalFileSize, tmpFileSize, state, downloadtype, progress, lastSpeedTime, intervalFileSize, lastStateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?)", model.vid, model.fileName, model.url, model.resumeData, [NSNumber numberWithInteger:model.totalFileSize], [NSNumber numberWithInteger:model.tmpFileSize], [NSNumber numberWithInteger:model.state], [NSNumber numberWithInteger:model.downloadtype], [NSNumber numberWithFloat:model.progress], [NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0]];
        if (result) {
            //            DentistLog(@"插入成功：%@", model.fileName);
        }else {
            NSLog(@"插入失败：%@", model.fileName);
        }
    }];
}

// 获取单条数据
- (DentistDownloadModel *)getModelWithUrl:(NSString *)url
{
    return [self getModelWithOption:DentistDBGetDateOptionModelWithUrl url:url];
}

// 获取第一条等待的数据
- (DentistDownloadModel *)getWaitingModel
{
    return [self getModelWithOption:DentistDBGetDateOptionWaitingModel url:nil];
}

// 获取最后一条正在下载的数据
- (DentistDownloadModel *)getLastDownloadingModel
{
    return [self getModelWithOption:DentistDBGetDateOptionLastDownloadingModel url:nil];
}

// 获取所有数据
- (NSArray<DentistDownloadModel *> *)getAllCacheData
{
    return [self getDateWithOption:DentistDBGetDateOptionAllCacheData];
}

// 根据lastStateTime倒叙获取所有正在下载的数据
- (NSArray<DentistDownloadModel *> *)getAllDownloadingData
{
    return [self getDateWithOption:DentistDBGetDateOptionAllDownloadingData];
}

// 获取所有下载完成的数据
- (NSArray<DentistDownloadModel *> *)getAllDownloadedData
{
    return [self getDateWithOption:DentistDBGetDateOptionAllDownloadedData];
}

// 获取所有未下载完成的数据
- (NSArray<DentistDownloadModel *> *)getAllUnDownloadedData
{
    return [self getDateWithOption:DentistDBGetDateOptionAllUnDownloadedData];
}

// 获取所有等待下载的数据
- (NSArray<DentistDownloadModel *> *)getAllWaitingData
{
    return [self getDateWithOption:DentistDBGetDateOptionAllWaitingData];
}

// 获取单条数据
- (DentistDownloadModel *)getModelWithOption:(DentistDBGetDateOption)option url:(NSString *)url
{
    __block DentistDownloadModel *model = nil;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet;
        switch (option) {
            case DentistDBGetDateOptionModelWithUrl:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE url = ?", url];
                break;
                
            case DentistDBGetDateOptionWaitingModel:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE state = ? order by lastStateTime asc limit 0,1", [NSNumber numberWithInteger:DentistDownloadStateWaiting]];
                break;
                
            case DentistDBGetDateOptionLastDownloadingModel:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE state = ? order by lastStateTime desc limit 0,1", [NSNumber numberWithInteger:DentistDownloadStateDownloading]];
                break;
                
            default:
                break;
        }
        
        while ([resultSet next]) {
            model = [[DentistDownloadModel alloc] initWithFMResultSet:resultSet];
        }
    }];
    
    return model;
}

// 获取数据集合
- (NSArray<DentistDownloadModel *> *)getDateWithOption:(DentistDBGetDateOption)option
{
    __block NSArray<DentistDownloadModel *> *array = nil;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet;
        switch (option) {
            case DentistDBGetDateOptionAllCacheData:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches"];
                break;
                
            case DentistDBGetDateOptionAllDownloadingData:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE state = ? order by lastStateTime desc", [NSNumber numberWithInteger:DentistDownloadStateDownloading]];
                break;
                
            case DentistDBGetDateOptionAllDownloadedData:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE state = ?", [NSNumber numberWithInteger:DentistDownloadStateFinish]];
                break;
                
            case DentistDBGetDateOptionAllUnDownloadedData:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE state != ?", [NSNumber numberWithInteger:DentistDownloadStateFinish]];
                break;
                
            case DentistDBGetDateOptionAllWaitingData:
                resultSet = [db executeQuery:@"SELECT * FROM t_downloadfileCaches WHERE state = ?", [NSNumber numberWithInteger:DentistDownloadStateWaiting]];
                break;
                
            default:
                break;
        }
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        while ([resultSet next]) {
            [tmpArr addObject:[[DentistDownloadModel alloc] initWithFMResultSet:resultSet]];
        }
        array = tmpArr;
    }];
    
    return array;
}

// 更新数据
- (void)updateWithModel:(DentistDownloadModel *)model option:(DentistDBUpdateOption)option
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (option & DentistDBUpdateOptionState) {
            [self postStateChangeNotificationWithFMDatabase:db model:model];
            [db executeUpdate:@"UPDATE t_downloadfileCaches SET state = ? WHERE url = ?", [NSNumber numberWithInteger:model.state], model.url];
        }
        if (option & DentistDBUpdateOptionLastStateTime) {
            [db executeUpdate:@"UPDATE t_downloadfileCaches SET lastStateTime = ? WHERE url = ?", [NSNumber numberWithInteger:[NSDate getTimeStampWithDate:[NSDate date]]], model.url];
        }
        if (option & DentistDBUpdateOptionResumeData) {
            [db executeUpdate:@"UPDATE t_downloadfileCaches SET resumeData = ? WHERE url = ?", model.resumeData, model.url];
        }
        if (option & DentistDBUpdateOptionProgressData) {
            [db executeUpdate:@"UPDATE t_downloadfileCaches SET tmpFileSize = ?, totalFileSize = ?, progress = ?, lastSpeedTime = ?, intervalFileSize = ? WHERE url = ?", [NSNumber numberWithInteger:model.tmpFileSize], [NSNumber numberWithFloat:model.totalFileSize], [NSNumber numberWithFloat:model.progress], [NSNumber numberWithInteger:model.lastSpeedTime], [NSNumber numberWithInteger:model.intervalFileSize], model.url];
        }
        if (option & DentistDBUpdateOptionAllParam) {
            [self postStateChangeNotificationWithFMDatabase:db model:model];
            [db executeUpdate:@"UPDATE t_downloadfileCaches SET resumeData = ?, totalFileSize = ?, tmpFileSize = ?, progress = ?, state = ?, lastSpeedTime = ?, intervalFileSize = ?, lastStateTime = ? WHERE url = ?", model.resumeData, [NSNumber numberWithInteger:model.totalFileSize], [NSNumber numberWithInteger:model.tmpFileSize], [NSNumber numberWithFloat:model.progress], [NSNumber numberWithInteger:model.state], [NSNumber numberWithInteger:model.lastSpeedTime], [NSNumber numberWithInteger:model.intervalFileSize], [NSNumber numberWithInteger:[NSDate getTimeStampWithDate:[NSDate date]]], model.url];
        }
    }];
}

// 状态变更通知
- (void)postStateChangeNotificationWithFMDatabase:(FMDatabase *)db model:(DentistDownloadModel *)model
{
    // 原状态
    NSInteger oldState = [db intForQuery:@"SELECT state FROM t_downloadfileCaches WHERE url = ?", model.url];
    if (oldState != model.state) {
        // 状态变更通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DentistDownloadStateChangeNotification object:model];
    }
}

// 删除数据
- (void)deleteModelWithUrl:(NSString *)url
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"DELETE FROM t_downloadfileCaches WHERE url = ?", url];
        if (result) {
            //            DentistLog(@"删除成功：%@", url);
        }else {
            NSLog(@"删除失败：%@", url);
        }
    }];
}


@end
