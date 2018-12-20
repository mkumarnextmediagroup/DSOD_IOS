//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIButton+styled.h"
#import "Colors.h"
#import "UIUtil.h"
#import "Fonts.h"
#import "UILabel+customed.h"


@implementation UIButton (styled)

+ (CGFloat)heightPrefer {
	return 40;
}

+ (CGFloat)widthLarge {
	return 330;
}

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

- (void)_styleCommmon {
	[self setTitleColor:Colors.textDisabled forState:UIControlStateDisabled];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonDisabled) forState:UIControlStateDisabled];
	self.titleLabel.font = [Fonts semiBold:15];
	[self.titleLabel wordSpace:-0.2f];
}

- (void)styleBlue {
	[self _styleCommmon];
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), rgb255(0, 0x7A, 0xB9)) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), rgb255(0, 56, 0x83)) forState:UIControlStateHighlighted];
}

- (void)stylePrimary {
	[self _styleCommmon];
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.primary) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonPrimaryActive) forState:UIControlStateHighlighted];
}

- (void)styleSecondary {
	[self _styleCommmon];
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.secondary) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonSecondaryActive) forState:UIControlStateHighlighted];
}

- (void)styleDisabled {
    [self _styleCommmon];
    [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self setBackgroundImage:colorImage(makeSize(1, 1), Colors.textDisabled) forState:UIControlStateNormal];
    [self setBackgroundImage:colorImage(makeSize(1, 1), Colors.buttonSecondaryActive) forState:UIControlStateHighlighted];
}

- (void)styleWhite {
	[self _styleCommmon];
	[self setTitleColor:Colors.textMain forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), UIColor.whiteColor) forState:UIControlStateNormal];
	[self setBackgroundImage:colorImage(makeSize(1, 1), rgb255(221, 221, 221)) forState:UIControlStateHighlighted];
}


- (void)title:(NSString *)text {
	[self setTitle:text forState:UIControlStateNormal];
}


- (void)textColorWhite {
	[self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}


@end
