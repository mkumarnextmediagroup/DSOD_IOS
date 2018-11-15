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
		_c = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
	}
	return _c;
}

+ (UIFont *)heading1 {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
	}
	return _c;
}

+ (UIFont *)heading2 {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
	}
	return _c;
}


+ (UIFont *)body {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
	}
	return _c;
}

+ (UIFont *)caption {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
	}
	return _c;
}

+ (UIFont *)tiny {
	static UIFont *_c = nil;
	if (_c == nil) {
		_c = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
	}
	return _c;
}


+ (UIFont *)heavy:(int)size {
	return [UIFont systemFontOfSize:size weight:UIFontWeightHeavy];
}

+ (UIFont *)bold:(int)size {
	return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}

+ (UIFont *)semiBold:(int)size {
	return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
}

+ (UIFont *)medium:(int)size {
	return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

+ (UIFont *)regular:(int)size {
	return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

+ (UIFont *)light:(int)size {
	return [UIFont systemFontOfSize:size weight:UIFontWeightLight];
}


@end
