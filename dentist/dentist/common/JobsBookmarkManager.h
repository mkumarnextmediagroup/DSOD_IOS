//
//  JobsBookmarkManager.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/25.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JobsBookmarkManager : NSObject
@property (nonatomic,strong) NSMutableArray *deleteArr;
@property (nonatomic,strong) NSMutableArray *addArr;
@property (nonatomic,strong) NSMutableArray *applyArr;
+ (instancetype)shareManager;
-(void)addBookmark:(NSString *)email postid:(NSString *)postid;

-(void)removeBookmark:(NSString *)email postid:(NSString *)postid;
//-(void)adddeleteBookmark:(NSString *)email postid:(NSString *)postid;
//
//-(void)removedeleteBookmark:(NSString *)email postid:(NSString *)postid;

-(BOOL)checkIsBookmark:(NSString *)email postid:(NSString *)postid;
-(BOOL)checkIsDeleteBookmark:(NSString *)email postid:(NSString *)postid;
-(void)addapplyBookmark:(NSString *)email postid:(NSString *)postid;
-(BOOL)checkIsApplyBookmark:(NSString *)email postid:(NSString *)postid;

-(NSString *)getPostid:(NSString *)email keyvalue:(NSString *)keyvalue;
@end
