//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/message.h>
#import "Platform.h"
#import "Common.h"


void objcSendMsg(id target, SEL action, id arg) {
	((void (*)(id, SEL, id)) objc_msgSend)(target, action, arg);
}


NSString *nameOfMonth(NSInteger m) {
	NSArray *ar = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
	if (m >= 1 && m <= 12) {
		return ar[(NSUInteger) (m - 1)];
	}
	return @"";
}

NSString *_toString(NSObject *obj) {
	if (obj == nil) {
		return @"null, ";
	}
	return strBuild([obj description], @", ");
}

__attribute__((overloadable)) extern void Log(id value) {
	NSString *buf = _toString(value);
	NSLog(@"%@", buf);
}

__attribute__((overloadable)) extern void Log(id value, id v2) {
	NSString *s = strBuild(_toString(value), _toString(v2));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3), _toString(v4));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3), _toString(v4), _toString(v5));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3), _toString(v4), _toString(v5), _toString(v6));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6, id v7) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3), _toString(v4), _toString(v5), _toString(v6), _toString(v7));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6, id v7, id v8) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3), _toString(v4), _toString(v5), _toString(v6), _toString(v7), _toString(v8));
	NSLog(@"%@", s);
}

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6, id v7, id v8, id v9) {
	NSString *s = strBuild(_toString(value), _toString(v2), _toString(v3), _toString(v4), _toString(v5), _toString(v6), _toString(v7), _toString(v8), _toString(v9));
	NSLog(@"%@", s);
}