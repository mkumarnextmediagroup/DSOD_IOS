//
//  BookmarkManager.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/27.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookmarkManager : NSObject
@property (nonatomic,strong) NSMutableArray *deleteArr;
+ (instancetype)shareManager;
-(void)adddeleteBookmark:(NSString *)email postid:(NSString *)postid;

-(void)removedeleteBookmark:(NSString *)email postid:(NSString *)postid;

-(BOOL)checkIsDeleteBookmark:(NSString *)email postid:(NSString *)postid;
@end

