//
// Created by yet on 2018/8/16.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Colors.h"
#import "UIUtil.h"


@implementation Colors {

}

+ (UIColor *)starColor {
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(66, 107, 242);
    }
    return _c;
}

+ (UIColor *)cellLineColor {
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(222, 222, 222);
    }
    return _c;
}

+ (UIColor *)bgNavBarColor {
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(120, 120, 120);
    }
    return _c;
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

//RGB color is #9B9B9B
+ (UIColor *)textAlternate {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(155, 155, 155);
	}
	return _c;
}

//RGB color is #4A4A4A
+ (UIColor *)textMain {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(74, 74, 74);
	}
	return _c;
}

//RGB color is #879AA8
+ (UIColor *)textDisabled {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(135, 154, 168);
	}
	return _c;
}

//RGB color is #354052
+ (UIColor *)textContent {
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(53, 64, 82);
    }
    return _c;
}


+ (UIColor *)borderSuccess {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(0, 214, 100);
	}
	return _c;
}

+ (UIColor *)borderError {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(208, 2, 27);
	}
	return _c;
}

+ (UIColor *)borderActive {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(74, 144, 226);
	}
	return _c;
}

+ (UIColor *)borderNormal {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(223, 227, 233);
	}
	return _c;
}

//RGB color is #E9EDF1
+ (UIColor *)bgDisabled {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(233, 237, 241);
	}
	return _c;
}


+ (UIColor *)buttonPrimaryActive {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(97, 120, 136);
	}
	return _c;
}


+ (UIColor *)buttonSecondaryActive {
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(47, 68, 84);
	}
	return _c;
}


+ (UIColor *)buttonDisabled {
	//E9EDF1
	static UIColor *_c = nil;
	if (_c == nil) {
		_c = rgb255(0xE9, 0xED, 0xF1);
	}
	return _c;
}

+ (UIColor *)bgColorNor {
    //E9EDF1
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(248, 248, 248);
    }
    return _c;
}

+ (UIColor *)bgColorUnite {
    //E9EDF1
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(239, 239, 239);
    }
    return _c;
}

+ (UIColor *)lineColorNor {
    //F1F1
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(241, 241, 241);
    }
    return _c;
}

+ (UIColor *)textColor9c {
    //9c9c9c
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(156, 156, 156);
    }
    return _c;
}

+ (UIColor *)textColorFAFBFD {
    //FAFBFD
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(250, 251, 253);
    }
    return _c;
}

+ (UIColor *)textColor3900 {
    //390000
    static UIColor *_c = nil;
    if (_c == nil) {
        _c = rgb255(140, 158, 172);
    }
    return _c;
}
@end

