//
// Created by yet on 2018/8/16.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#ifndef __UIUTIL__
#define __UIUTIL__

#import <UIKit/UIKit.h>

extern NSString *localStr(NSString *name);

extern UIColor *rgbHex(int rgbValue);

extern UIColor *argbHex(int argbValue);

extern UIColor *rgb255(int r, int g, int b);

extern UIColor *rgba255(int r, int g, int b, int a);

extern UIImage *colorImage(CGSize size, UIColor *color);

extern CGSize makeSize(int w, int h);

extern CGSize makeSizeF(CGFloat w, CGFloat h);

extern CGRect makeRect(int x, int y, int w, int h);

extern CGRect makeRectF(CGFloat x, CGFloat y, CGFloat w, CGFloat h);

extern  UINavigationController *NavPage(UIViewController* c );
extern  UITabBarController *TabPage(NSArray<__kindof UIViewController *> *cs );
extern  UITabBarController *TabNavPage(NSArray<__kindof UIViewController *> *cs);
#endif
