//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSMutableAttributedString+customed.h"


@implementation NSMutableAttributedString (customed)


- (void)paragraphStyle:(NSMutableParagraphStyle *)ps {
	[self setAttr:NSParagraphStyleAttributeName value:ps];
}

- (void)wordSpace:(CGFloat)f {
	[self setAttr:NSKernAttributeName value:@(f)];
}

- (void)underlineSingle {
	[self setAttr:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle)];
}

- (void)backColor:(UIColor *)color {
	[self setAttr:NSBackgroundColorAttributeName value:color];
}

- (void)foreColor:(UIColor *)color {
	[self setAttr:NSForegroundColorAttributeName value:color];
}

- (void)font:(UIFont *)font {
	[self setAttr:NSFontAttributeName value:font];
}

- (void)setAttr:(NSAttributedStringKey)name value:(id)value {
	[self addAttribute:name value:value range:NSMakeRange(0, self.length)];
}

- (id)attr:(NSAttributedStringKey)name {
	NSRange r = NSMakeRange(0, self.length);
	return [self attribute:name atIndex:0 effectiveRange:&r];
}

@end