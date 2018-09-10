//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#ifndef  __PLATFORM__
#define  __PLATFORM__


#import <UIKit/UIKit.h>

extern void objcSendMsg(id target, SEL action, id arg);


#define Log(first, ...)  _Log(first, @[ __VA_ARGS__ ])

extern void _Log(NSObject *first, NSArray *array);

#endif
