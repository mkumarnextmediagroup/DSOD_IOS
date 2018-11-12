//
// Created by yet on 2018/8/16.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIUtil.h"


NSString *localStr(NSString *name) {
	return NSLocalizedString(name, nil);
}

UIColor *rgbHex(int rgbValue){
   CGFloat fr = ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0f;
   CGFloat fg = ((float)((rgbValue & 0xFF00) >> 8)) / 255.0f;
   CGFloat fb = ((float)(rgbValue & 0xFF)) / 255.0f;
   return [[UIColor alloc] initWithRed:fr green:fg blue:fb alpha:1.0];
}

UIColor *argbHex(int argbValue){
    CGFloat fa = ((float)((argbValue & 0xFF000000) >> 24)) / 255.0f;
    CGFloat fr = ((float)((argbValue & 0xFF0000) >> 16)) / 255.0f;
    CGFloat fg = ((float)((argbValue & 0xFF00) >> 8)) / 255.0f;
    CGFloat fb = ((float)(argbValue & 0xFF)) / 255.0f;
    return [[UIColor alloc] initWithRed:fr green:fg blue:fb alpha:fa];
}

UIColor *rgb255(int r, int g, int b) {
	CGFloat fr = r / 255.0f;
	CGFloat fg = g / 255.0f;
	CGFloat fb = b / 255.0f;
	return [[UIColor alloc] initWithRed:fr green:fg blue:fb alpha:1.0];
}

UIColor *rgba255(int r, int g, int b, int a) {
	CGFloat fr = r / 255.0f;
	CGFloat fg = g / 255.0f;
	CGFloat fb = b / 255.0f;
	CGFloat fa = a / 255.0f;
	return [[UIColor alloc] initWithRed:fr green:fg blue:fb alpha:fa];
}


UIImage *colorImage(CGSize size, UIColor *color) {
	UIGraphicsBeginImageContext(size);
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(c, color.CGColor);
	CGContextFillRect(c, CGRectMake(0, 0, size.width, size.height));
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

CGSize makeSize(int w, int h) {
	return CGSizeMake(w, h);
}

CGSize makeSizeF(CGFloat w, CGFloat h) {
	return CGSizeMake(w, h);
}

CGRect makeRect(int x, int y, int w, int h) {
	return CGRectMake(x, y, w, h);
}

CGRect makeRectF(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
	return CGRectMake(x, y, w, h);
}


UINavigationController *NavPage(UIViewController *c) {
	return [[UINavigationController alloc] initWithRootViewController:c];
}

UITabBarController *TabPage(NSArray<__kindof UIViewController *> *cs) {
	UITabBarController *tabC = [UITabBarController new];
	[tabC setViewControllers:cs];
	return tabC;
}

UITabBarController *TabNavPage(NSArray<__kindof UIViewController *> *cs) {
	UITabBarController *tabC = [UITabBarController new];
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:cs.count];
	for (UIViewController *c in cs) {
		UINavigationController *nc = NavPage(c);
		[arr addObject:nc];
	}
	[tabC setViewControllers:arr];
	return tabC;
}
