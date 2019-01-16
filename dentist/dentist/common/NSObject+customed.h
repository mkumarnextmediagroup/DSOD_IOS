//
//  NSObject+customed.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/16.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (customed)
- (NSDictionary *)dicFromObject:(NSObject *)object;
- (id)arrayOrDicWithObject:(id)origin;
@end
