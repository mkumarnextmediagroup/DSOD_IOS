//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIImage+customed.h"
#import "Common.h"


@implementation UIImage (customed)

- (UIImage *)scaledTo:(CGFloat)w h:(CGFloat)h {
	UIGraphicsBeginImageContext(makeSizeF(w, h));
	CGContextRef c = UIGraphicsGetCurrentContext();

	[self drawInRect:makeRectF(0, 0, w, h)];

	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}


@end