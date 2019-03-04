//
//  LMSLessonsModel.m
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "LMSLessonModel.h"

@implementation LMSLessonModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description" : @"lessonDescription"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}


@end
