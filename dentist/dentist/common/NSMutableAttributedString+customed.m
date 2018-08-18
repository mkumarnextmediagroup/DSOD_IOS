//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSMutableAttributedString+customed.h"


@implementation NSMutableAttributedString (customed)

- (void)underlineSingle {
	[self addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, self.length)];
}

- (void)backColor:(UIColor *)color {
	[self addAttribute:NSBackgroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
}

- (void)foreColor:(UIColor *)color {
	[self addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
}

- (void)font:(UIFont *)font {
	[self addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
}
@end