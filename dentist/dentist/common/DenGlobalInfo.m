//
//  DenGlobalInfo.m
//  dentist
//
//  Created by Jacksun on 2018/9/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DenGlobalInfo.h"

@implementation DenGlobalInfo

+ (instancetype)sharedInstance
{
    static DenGlobalInfo *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DenGlobalInfo alloc] init];
    });
    
    return instance;
}

//the user's role
- (NSString *)identity
{
    return _identity;
}

@end
