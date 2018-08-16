//
// Created by yet on 2018/8/16.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Colors.h"
#import "UIUtil.h"


@implementation Colors {

}


+ (UIColor *)primary {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(135, 154, 168);
	}
	return _c;
}


+ (UIColor *)secondary {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(94, 110, 122);
	}
	return _c;
}


+ (UIColor *)strokes {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(233, 237, 241);
	}
	return _c;
}


+ (UIColor *)success {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(102, 175, 36);
	}
	return _c;
}


+ (UIColor *)error {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(184, 81, 81);
	}
	return _c;
}


+ (UIColor *)alert {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(254, 166, 35);
	}
	return _c;
}


+ (UIColor *)textAlternate {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(0, 122, 185);
	}
	return _c;
}


+ (UIColor *)textMain {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(74, 74, 74);
	}
	return _c;
}

@end

