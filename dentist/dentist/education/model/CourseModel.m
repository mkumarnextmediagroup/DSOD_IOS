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
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"description" : @"courseDescription"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}


-(NSString*)levelString{
    //1.beginner，2.intermediate，3.advanced，4.expert
    if([self.level isEqualToString:@"1"]) {
        return @"beginner";
    }else if([self.level isEqualToString:@"2"]){
        return @"intermediate";
    }else if([self.level isEqualToString:@"3"]){
        return @"advanced";
    }else if([self.level isEqualToString:@"4"]){
        return @"expert";
    }else{
        return @"beginner";
    }
}


@end
