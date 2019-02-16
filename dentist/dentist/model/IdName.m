//
// Created by entaoyang on 2018/9/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "IdName.h"
#import "JSONModel.h"


@implementation IdName {
    
}
+ (JSONKeyMapper *)keyMapper{
    // 属性名作为key ,字典中的key名 作为 value
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"descriptions":@"description"}];
}
@end
