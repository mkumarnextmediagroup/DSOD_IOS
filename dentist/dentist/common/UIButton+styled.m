//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIButton+styled.h"
#import "Colors.h"
#import "UIUtil.h"


@implementation UIButton (styled)

+ (CGFloat)heightPrefer {
	return 40;
}

+ (CGFloat)widthLarge {
	return 330;
}

- (UIButton *)styleBlue {
	//5683
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	[self setTitleColor:Colors.textAlternate forState:UIControlStateDisabled];
	[self setBackgroundImage:colorImage(makeSize(1, 1), rgb255(0, 0x7A, 0xB9)) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), rgb255(0, 56, 0x83)) forState:UIControlStateHighlighted];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonDisabled) forState:UIControlStateDisabled];
	return self;
}

- (UIButton *)stylePrimary {
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	[self setTitleColor:Colors.textAlternate forState:UIControlStateDisabled];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.primary) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonPrimaryActive) forState:UIControlStateHighlighted];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonDisabled) forState:UIControlStateDisabled];
	return self;
}

- (UIButton *)styleSecondary {
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	[self setTitleColor:Colors.textAlternate forState:UIControlStateDisabled];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.secondary) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonSecondaryActive) forState:UIControlStateHighlighted];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonDisabled) forState:UIControlStateDisabled];
	return self;
}

- (UIButton *)styleWhite {
	[self setTitleColor:Colors.textMain forState:UIControlStateNormal];
	[self setTitleColor:Colors.textAlternate forState:UIControlStateDisabled];
	[self setBackgroundImage:colorImage(makeSize(1, 1), UIColor.whiteColor) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), rgb255(221, 221, 221)) forState:UIControlStateHighlighted];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonDisabled) forState:UIControlStateDisabled];
	return self;
}

- (UIButton *)title:(NSString *)text {
	[self setTitle:text forState:UIControlStateNormal];
	return self;
}


- (void)textColorWhite {
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}


@end
