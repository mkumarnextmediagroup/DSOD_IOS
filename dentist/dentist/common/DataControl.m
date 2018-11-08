//
//  DataControl.m
//  dentist
//
//  Created by cstLBY on 2018/10/17.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DataControl.h"

@implementation DataControl
+ (void)saveCache:(NSDictionary *)dataArr plistName:(NSString *)plistName
{
    //异步串行
    dispatch_async(dispatch_queue_create("com.savedatadictionary.event", DISPATCH_QUEUE_SERIAL), ^{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        NSString *cachePath = [NSString stringWithFormat:@"Caches/%@",plistName];
        NSString *fileName = [path stringByAppendingPathComponent:cachePath];
        [dataArr writeToFile:fileName atomically:YES];
    });
    
}

+ (void)saveCacheNormal:(NSDictionary *)dataArr plistName:(NSString *)plistName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *cachePath = [NSString stringWithFormat:@"Caches/%@",plistName];
    NSString *fileName = [path stringByAppendingPathComponent:cachePath];
    [dataArr writeToFile:fileName atomically:YES];
    
}

+ (NSDictionary *)readPlistOfCache:(NSString *)plistName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];//[paths objectAtIndex:0];
    NSString *cachePath = [NSString stringWithFormat:@"Caches/%@",plistName];
    NSString *fileName = [path stringByAppendingPathComponent:cachePath];
    NSDictionary *dataArr = [[NSDictionary alloc] initWithContentsOfFile:fileName];
    
    return dataArr;
}
+ (void)saveArrayCache:(NSArray *)dataArr plistName:(NSString *)plistName
{
    //异步串行
    dispatch_async(dispatch_queue_create("com.savedatansarray.event", DISPATCH_QUEUE_SERIAL), ^{
        NSString *fileName = [NSString stringWithFormat:@"Library/Caches/%@",plistName];
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
        [dataArr writeToFile:path atomically:YES];
    });
    
}

+ (void)saveArrayCacheNormal:(NSArray *)dataArr plistName:(NSString *)plistName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];//[paths objectAtIndex:0];
    NSString *cachePath = [NSString stringWithFormat:@"Caches/%@",plistName];
    NSString *fileName = [path stringByAppendingPathComponent:cachePath];
    [dataArr writeToFile:fileName atomically:YES];
    
}

+ (NSArray *)readArrPlistOfCache:(NSString *)plistName
{
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];//[paths objectAtIndex:0];
    NSString *cachePath = [NSString stringWithFormat:@"Caches/%@",plistName];
    NSString *fileName = [path stringByAppendingPathComponent:cachePath];
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:fileName];
    return dataArr;
    //    return [NSMutableArray array];
}
@end
