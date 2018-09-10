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


NSString *_toString(NSObject *obj) {
	if (obj == nil) {
		return @"null";
	}
	return [obj description];
}

void _Log(NSObject *first, NSArray *array) {
	NSString *buf = _toString(first);
	if (array != nil) {
		for (NSObject *ob in array) {
			buf = strBuild(buf, @", ", _toString(ob));
		}
	}
	NSLog(@"%@", buf);
}
