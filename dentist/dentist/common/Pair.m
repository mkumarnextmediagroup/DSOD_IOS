//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Pair.h"


@implementation Pair {

}
+ (instancetype)create:(NSString *)key value:(NSString *)value {
	Pair *p = [Pair new];
	p.key = key;
	p.value = value;
	return p;
}
@end