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
    // 数据库文件路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CMSCaches.sqlite"];
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
            info.name = item.email;
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DetinstDownloadStateChangeNotification" object:model];
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
//MARK:unite 杂志表
-(void)creatUniteCachesTable:(FMDatabase *)db
{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_UniteCaches (id VARCHAR(100) PRIMARY KEY,serial text,vol text,publishDate VARCHAR(100),cover text,articles text,createDate VARCHAR(100),createUser text,issue text,jsontext text,downstatus INTEGER default 0,isarchive INTEGER default 0, createtime timestamp not null default CURRENT_TIMESTAMP)"];
    if (result) {
        NSLog(@"缓存t_UniteCaches数据表创建成功");
    }else {
        NSLog(@"缓存t_UniteCaches数据表创建失败");
    }
}

//MARK:unite 杂志文章表
-(void)creatUniteArticlesCachesTable:(FMDatabase *)db
{
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_UniteArticlesCaches (id VARCHAR(100),uniteid VARCHAR(100),title text,contentTypeId VARCHAR(100),categoryId VARCHAR(100),contentTypeName VARCHAR(100),categoryName VARCHAR(100), jsontext text,isbookmark INTEGER default 0,downstatus INTEGER default 0,sort INTEGER default 0, createdate timestamp not null default CURRENT_TIMESTAMP, bookmarktime timestamp not null default CURRENT_TIMESTAMP,PRIMARY KEY(id,uniteid))"];
    if (result) {
        NSLog(@"缓存t_UniteArticles数据表创建成功");
    }else {
        NSLog(@"缓存t_UniteArticles数据表创建失败");
    }
}

// 插入数据
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
                    result = [db executeUpdate:@"UPDATE t_UniteCaches set serial = ?,vol = ?,publishDate = ?,cover = ?,articles = ?,createDate = ?,createUser = ?,issue = ? where id = ? ", serial,vol,publishDate,cover,articles,createDate,createUser,issue,_id];
                    
                    if (result) {
                    }else {
                        NSLog(@"更新Unite失败");
                    }
                    
                }else{
                    
                    result = [db executeUpdate:@"INSERT INTO t_UniteCaches (id ,serial,vol,publishDate,cover,articles,createDate,createUser,issue) VALUES (?,?, ?, ?, ?, ?, ?,?, ?)", _id,serial,vol,publishDate,cover,articles,createDate,createUser,issue];
                    
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
- (void)insertUniteArticleModel:(DetailModel *)model uniteid:(NSString *)uniteid jsontext:(NSString *)jsontext sort:(NSInteger)sort completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:model.id] && ![NSString isBlankString:uniteid]) {
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                if ([self CheckIsHasUniteArticle:db articleid:model.id uniteid:uniteid]) {
                    //更新
                    result = [db executeUpdate:@"UPDATE t_UniteArticlesCaches set title = ?,contentTypeId = ?,categoryId = ?,contentTypeName = ?,categoryName = ?,jsontext = ?,sort = ? where id = ? and uniteid = ? ",model.title,model.contentTypeId,model.categoryId,model.contentTypeName,model.categoryName,jsontext,[NSNumber numberWithInteger:sort],model.id,uniteid];
                    
                    if (result) {
                    }else {
                        NSLog(@"更新Unite失败");
                    }
                    
                }else{
                    
                    result = [db executeUpdate:@"INSERT INTO t_UniteArticlesCaches (id,uniteid,title,contentTypeId,categoryId ,contentTypeName ,categoryName, jsontext,sort) VALUES (?,?, ?, ?, ?, ?, ?,?,?)", model.id,uniteid,model.title,model.contentTypeId,model.categoryId,model.contentTypeName,model.categoryName,jsontext,[NSNumber numberWithInteger:sort]];
                    
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

-(BOOL)CheckIsHasUnite:(FMDatabase *)db uniteid:(NSString *)uniteid
{
    NSInteger status = [db intForQuery:@"SELECT 1 FROM t_UniteCaches WHERE id = ?", uniteid];
    if (status==1) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)CheckIsHasUniteArticle:(FMDatabase *)db articleid:(NSString *)articleid uniteid:(NSString *)uniteid
{
    NSInteger status = [db intForQuery:@"SELECT 1 FROM t_UniteArticlesCaches WHERE id = ? and uniteid = ?",articleid, uniteid];
    if (status==1) {
        return YES;
    }else{
        return NO;
    }
}

-(void)queryUniteArticlesCachesList:(NSString *)uniteid completed:(void(^)(NSArray<DetailModel *> *array))completed
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *resultSet;
            resultSet = [db executeQuery:@"SELECT * FROM t_UniteArticlesCaches where uniteid = ? order by sort ",uniteid];
            
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
}

//添加删除杂志文章方法，isbookmark==1收藏；0取消收藏
-(void)updateUniteArticleBookmark:(NSString *)articleid uniteid:(NSString *)uniteid isbookmark:(NSInteger)isbookmark completed:(void(^)(BOOL result))completed
{
    if (![NSString isBlankString:uniteid] && ![NSString isBlankString:articleid]) {
        __block BOOL result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_dbQueue inDatabase:^(FMDatabase *db) {
                
                result = [db executeUpdate:@"update t_UniteArticlesCaches set isbookmark = ?,bookmarktime=datetime('now')  where id = ? and uniteid = ? ",[NSNumber numberWithInteger:isbookmark],articleid,uniteid];
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

-(void)queryUniteArticlesBookmarkCachesList:(void(^)(NSArray<DetailModel *> *array))completed
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self->_dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *resultSet;
            resultSet = [db executeQuery:@"SELECT * FROM t_UniteArticlesCaches where isbookmark=1 order by bookmarktime "];
            
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
}


@end
