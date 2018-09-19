//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIImage+customed.h"
#import "Common.h"


@implementation UIImage (customed)

- (UIImage *)scaledTo:(CGFloat)w h:(CGFloat)h {
	UIGraphicsBeginImageContext(makeSizeF(w, h));
	[self drawInRect:makeRectF(0, 0, w, h)];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

- (UIImage *)scaledBy:(CGFloat)f {
	CGFloat w = self.size.width * f;
	CGFloat h = self.size.height * f;
	return [self scaledTo:w h:h];
}


@end