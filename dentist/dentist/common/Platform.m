//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/message.h>
#import "Platform.h"


void objcSendMsg(id target, SEL action, id arg) {
	((void (*)(id, SEL, id)) objc_msgSend)(target, action, arg);
}

