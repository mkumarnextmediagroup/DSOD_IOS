//
//  DiscussInfo.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscussInfo : NSObject<NSCoding>

@property NSString *disImg;
@property NSString *name;
@property NSInteger starCount;
@property NSString *disDate;
@property NSString *content;


@end
