//
//  CourseModel.m
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "CourseModel.h"

@implementation CourseModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description" : @"courseDescription"}];
}
@end
