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
#import "Fonts.h"

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


- (void)itemTitleStyle {
	self.font = [Fonts regular:12];
	[self textColorAlternate];
}

- (void)setTextWithDifColor:(NSString *)text
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"*"].location, [[noteStr string] rangeOfString:@"*"].length);
    //the location need to set
    [noteStr addAttribute:NSForegroundColorAttributeName value:Colors.starColor range:redRange];
    //set color
    [self setAttributedText:noteStr];

}

- (void)itemPrimaryStyle {
	self.font = [Fonts regular:15];
	[self textColorBlack];
}

- (void)onClick:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    TapGesture *t = [[TapGesture alloc] initWithTarget:self action:@selector(_onClickLabel:)];
    t.target = target;
    t.action = action;
    [self addGestureRecognizer:t];
}

- (void)_onClickLabel:(UITapGestureRecognizer *)recognizer {
    TapGesture *t = (TapGesture *) recognizer;
    objcSendMsg(t.target, t.action, t.view);
}
@end
