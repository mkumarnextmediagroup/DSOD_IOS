//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#ifndef  __PLATFORM__
#define  __PLATFORM__


#import <UIKit/UIKit.h>

extern void objcSendMsg(id target, SEL action, id arg);


//m in [1, 12]
extern NSString *nameOfMonth(NSInteger m);

__attribute__((overloadable)) extern void Log(id value);

__attribute__((overloadable)) extern void Log(id value, id v2);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6, id v7);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6, id v7, id v8);

__attribute__((overloadable)) extern void Log(id value, id v2, id v3, id v4, id v5, id v6, id v7, id v8, id v9);

#endif
