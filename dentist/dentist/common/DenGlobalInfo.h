//
//  DenGlobalInfo.h
//  dentist
//
//  Created by Jacksun on 2018/9/7.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DenGlobalInfo : NSObject

+ (instancetype)sharedInstance;

@property (copy, nonatomic)NSString *identity;

@end
