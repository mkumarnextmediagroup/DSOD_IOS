//
//  FAQSModel.m
//  dentist
//
//  Created by Shirley on 2019/1/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "FAQSModel.h"

@implementation FAQSModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description" : @"desc"}];
}

@end
