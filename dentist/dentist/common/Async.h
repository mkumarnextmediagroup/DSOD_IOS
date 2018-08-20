//
// Created by yet on 2018/8/20.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

extern void foreTask(dispatch_block_t block);

extern void backTask(dispatch_block_t block);

extern void foreDelay(int millSec, dispatch_block_t block);

extern void backDelay(int millSec, dispatch_block_t block);

extern void foreAction(id target, SEL action, id arg);

extern void backAction(id target, SEL action, id arg);

extern void foreActionDelay(int millSec, id target, SEL action, id arg);

extern void backActionDelay(int millSec, id target, SEL action, id arg);