//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UITextField+styled.h"
#import "Colors.h"
#import "NSMutableAttributedString+customed.h"
#import "Fonts.h"
#import "Common.h"


@implementation UITextField (styled)

- (NSString *)hint {
	NSAttributedString *s = self.attributedPlaceholder;
	if (s == nil) {
		return nil;
	}
	return s.string;
}

- (void)setHint:(NSString *)s {
	NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:s];
	[as font:[Fonts regular:15]];
	[as foreColor:rgb255(0x9B, 0x9B, 0x9B)];
	self.attributedPlaceholder = as;

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

- (void)textColorMain {
	self.textColor = Colors.textMain;
}

- (void)textColorAlternate {
	self.textColor = Colors.textAlternate;
}

- (void)styleRound:(UIColor *)borderColor {
	self.borderStyle = UITextBorderStyleRoundedRect;
	self.layer.borderColor = borderColor.CGColor;
	self.layer.borderWidth = 1;
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = YES;

	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	[self textColorMain];

	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;
	self.rightView = nil;
}

- (void)styleDisabled {
	[self styleRound:Colors.bgDisabled];
	self.backgroundColor = Colors.bgDisabled;
}


- (void)styleNormal {
	[self styleRound:Colors.borderNormal];
}

- (void)styleActive {
	[self styleRound:Colors.borderActive];
}

- (void)styleError {
	[self styleRound:Colors.borderError];
	UIImage *img = [UIImage imageNamed:@"error"];
	UIImageView *iv = [[UIImageView alloc] initWithImage:img];
	self.rightView = iv;
	self.rightViewMode = UITextFieldViewModeUnlessEditing;
}

- (void)styleSuccess {
	[self styleRound:Colors.borderSuccess];
	UIImage *img = [UIImage imageNamed:@"ok"];
	UIImageView *iv = [[UIImageView alloc] initWithImage:img];
	self.rightView = iv;
	self.rightViewMode = UITextFieldViewModeUnlessEditing;
}


- (void)styleLine:(UIColor *)borderColor {
	CALayer *ly = CALayer.layer;
	ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
	ly.backgroundColor = borderColor.CGColor;
	self.borderStyle = UITextBorderStyleNone;
	[self.layer addSublayer:ly];

	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	[self textColorMain];

	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;
	self.rightView = nil;
}


- (void)styleLineDisabled {
	[self styleLine:UIColor.whiteColor];
	[self textColorAlternate];
}


- (void)styleLineNormal {
	[self styleLine:Colors.borderNormal];
}

- (void)styleLineActive {
	[self styleLine:Colors.borderActive];
}

- (void)styleLineError {
	[self styleLine:Colors.borderError];
}

- (void)styleLineSuccess {
	[self styleLine:Colors.borderSuccess];
}


@end