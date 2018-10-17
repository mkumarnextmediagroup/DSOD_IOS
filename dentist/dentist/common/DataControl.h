//
//  DataControl.h
//  dentist
//
//  Created by cstLBY on 2018/10/17.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataControl : NSObject
+ (void)saveCache:(NSDictionary *)dataArr plistName:(NSString *)plistName;
+ (NSDictionary *)readPlistOfCache:(NSString *)plistName;
+ (void)saveArrayCache:(NSArray *)dataArr plistName:(NSString *)plistName;
+ (void)saveArrayCacheNormal:(NSArray *)dataArr plistName:(NSString *)plistName;
+ (NSArray *)readArrPlistOfCache:(NSString *)plistName;
@end

