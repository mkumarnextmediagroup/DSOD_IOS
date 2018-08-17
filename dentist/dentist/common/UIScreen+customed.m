//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIScreen+customed.h"


@implementation UIScreen (customed)

+ (CGFloat)height {
	static CGFloat h = 0;
	if (h == 0) {
		h = UIScreen.mainScreen.bounds.size.height;
	}
	return h;
}

+ (CGFloat)width {
	static CGFloat w = 0;
	if (w == 0) {
		w = UIScreen.mainScreen.bounds.size.width;
	}
	return w;
}
@end