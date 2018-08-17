//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Fonts.h"


@implementation Fonts {

}

+ (UIFont *)title {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:15 weight: UIFontWeightSemibold];
	}
	return _c;
}
+ (UIFont *)heading1 {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:20 weight: UIFontWeightSemibold];
	}
	return _c;
}
+ (UIFont *)heading2 {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:17 weight: UIFontWeightMedium];
	}
	return _c;
}


+ (UIFont *)body {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:13 weight: UIFontWeightRegular];
	}
	return _c;
}

+ (UIFont *)caption {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:14 weight: UIFontWeightSemibold];
	}
	return _c;
}
+ (UIFont *)tiny {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:12 weight: UIFontWeightRegular];
	}
	return _c;
}

@end