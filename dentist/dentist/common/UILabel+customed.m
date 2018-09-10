//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/message.h>
#import "UILabel+customed.h"
#import "NSMutableAttributedString+customed.h"
#import "TapGesture.h"
#import "Platform.h"
#import "Colors.h"

@implementation UILabel (customed)


- (CGFloat)heightThatFit {
	CGSize sz = [self sizeThatFits:CGSizeZero];
	return sz.height;
}

- (CGFloat)widthThatFit {
	CGSize sz = [self sizeThatFits:CGSizeZero];
	return sz.height;
}

- (void)textAlignCenter {
	self.textAlignment = NSTextAlignmentCenter;
}

- (void)textAlignLeft {
	self.textAlignment = NSTextAlignmentLeft;
}

- (void)textAlignRight {
	self.textAlignment = NSTextAlignmentRight;
}

- (void)textColorWhite {
	self.textColor = UIColor.whiteColor;
}

- (void)textColorBlack {
	self.textColor = UIColor.blackColor;
}

- (void)textColorMain {
	self.textColor = Colors.textMain;
}


- (void)textColorPrimary {
	self.textColor = Colors.primary;
}

- (void)textColorSecondary {
	self.textColor = Colors.secondary;
}
- (void)textColorAlternate {
	self.textColor = Colors.textAlternate;
}

- (void)lineSpace:(CGFloat)space {
	NSMutableAttributedString *as = self.mutableAttrString;
	NSMutableParagraphStyle *p = [NSMutableParagraphStyle new];
	NSParagraphStyle *ps = [as attr:NSParagraphStyleAttributeName];
	if (ps != nil) {
		[p setParagraphStyle:ps];
	}
	p.lineSpacing = space;
	[as paragraphStyle:p];
	self.attributedText = as;
}

- (void)wordSpace:(CGFloat)f {
	NSMutableAttributedString *as = self.mutableAttrString;
	[as wordSpace:f];
	self.attributedText = as;
}


- (NSMutableAttributedString *)mutableAttrString {
	if (self.attributedText != nil) {
		return [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	}

	if (self.text != nil) {
		return [[NSMutableAttributedString alloc] initWithString:self.text];
	}
	return nil;
}


- (void)underLineSingle {
	NSMutableAttributedString *as = self.mutableAttrString;
	[as underlineSingle];
	self.attributedText = as;
}


@end
