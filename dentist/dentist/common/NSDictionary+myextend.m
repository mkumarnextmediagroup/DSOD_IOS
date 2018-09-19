//
// Created by entaoyang on 2018/9/20.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSDictionary+myextend.h"


@implementation NSDictionary (myextend)


- (NSString *)strValue:(NSString *)key {
	id v = self[key];
	if (v == nil || v == NSNull.null) {
		return nil;
	}
	return v;
}

- (BOOL)boolValue:(NSString *)key {
	id v = self[key];
	if (v == nil || v == NSNull.null) {
		return NO;
	}
	if ([v isKindOfClass:NSString.class]) {
		return [@"1" isEqualToString:v] || [@"true" isEqualToString:v];
	}
	NSNumber *num = v;
	return num.boolValue;
}


- (NSInteger)intValue:(NSString *)key {
	id v = self[key];
	if (v == nil || v == NSNull.null) {
		return 0;
	}
	if ([v isKindOfClass:NSString.class]) {
		NSString *s = v;
		return s.intValue;
	}
	NSNumber *num = v;
	return num.intValue;
}


@end