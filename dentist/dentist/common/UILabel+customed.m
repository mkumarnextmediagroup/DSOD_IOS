//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/message.h>
#import "UILabel+customed.h"
#import "NSMutableAttributedString+customed.h"
#import "TapGesture.h"
#import "Platform.h"


@implementation UILabel (customed)


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


- (void)underLineSingle {
	NSString *s = self.text;
	if (s == nil) {
		return;
	}
	NSMutableAttributedString *as = nil;
	if (self.attributedText == nil) {
		as = [[NSMutableAttributedString alloc] initWithString:self.text];
	} else {
		as = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	}
	[as underlineSingle];
	self.attributedText = as;
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