//
// Created by yet on 2018/8/20.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Async.h"
#import "Platform.h"


void foreTask(dispatch_block_t block) {
	dispatch_queue_t q = dispatch_get_main_queue();
	dispatch_async(q, block);
}

void backTask(dispatch_block_t block) {
	dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	dispatch_async(q, block);
}

void foreDelay(int millSec, dispatch_block_t block) {
	dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (millSec * NSEC_PER_MSEC));
	dispatch_queue_t q = dispatch_get_main_queue();
	dispatch_after(t, q, block);
}

void backDelay(int millSec, dispatch_block_t block) {
	dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (millSec * NSEC_PER_MSEC));
	dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	dispatch_after(t, q, block);
}

void foreAction(id target, SEL action, id arg) {
	foreTask(^() {
		objcSendMsg(target, action, arg);
	});
}

void backAction(id target, SEL action, id arg) {
	backTask(^() {
		objcSendMsg(target, action, arg);
	});
}

void foreActionDelay(int millSec, id target, SEL action, id arg) {
	foreDelay(millSec, ^() {
		objcSendMsg(target, action, arg);
	});
}

void backActionDelay(int millSec, id target, SEL action, id arg) {
	backDelay(millSec, ^() {
		objcSendMsg(target, action, arg);
	});
}