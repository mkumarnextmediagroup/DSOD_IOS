//
//  LMSCategoryModel.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "LMSCategoryModel.h"

@implementation LMSCategoryModel
+ (JSONKeyMapper *)keyMapper{
    // 属性名作为key ,字典中的key名 作为 value
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"descriptions":@"description"}];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
