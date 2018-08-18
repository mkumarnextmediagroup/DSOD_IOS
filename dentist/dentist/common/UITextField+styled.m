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

-(NSString*) hint {
	NSAttributedString * s = self.attributedPlaceholder;
	if(s == nil) {
		return nil ;
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

- (UITextField *)textColorMain {
	self.textColor = Colors.textMain;
	return self;
}

- (UITextField *)textColorAlternate {
	self.textColor = Colors.textAlternate;
	return self;
}

- (UITextField *)styleRound:(UIColor *)borderColor {
	self.borderStyle = UITextBorderStyleRoundedRect;
	self.layer.borderColor = borderColor.CGColor;
	self.layer.borderWidth = 1;
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = YES;

	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.textColorMain;

	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;
	self.rightView = nil;
	return self;
}

- (UITextField *)styleDisabled {
	[self styleRound:Colors.bgDisabled];
	self.backgroundColor = Colors.bgDisabled;
	return self;
}


- (UITextField *)styleNormal {
	[self styleRound:Colors.borderNormal];
	return self;
}

- (UITextField *)styleActive {
	[self styleRound:Colors.borderActive];
	return self;
}

- (UITextField *)styleError {
	[self styleRound:Colors.borderError];
	UIImage *img = [UIImage imageNamed:@"error"];
	UIImageView *iv = [[UIImageView alloc] initWithImage:img];
	self.rightView = iv;
	self.rightViewMode = UITextFieldViewModeUnlessEditing;
	return self;
}

- (UITextField *)styleSuccess {
	[self styleRound:Colors.borderSuccess];
	UIImage *img = [UIImage imageNamed:@"ok"];
	UIImageView *iv = [[UIImageView alloc] initWithImage:img];
	self.rightView = iv;
	self.rightViewMode = UITextFieldViewModeUnlessEditing;
	return self;
}


- (UITextField *)styleLine:(UIColor *)borderColor {
	CALayer *ly = CALayer.layer;
	ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
	ly.backgroundColor = borderColor.CGColor;
	self.borderStyle = UITextBorderStyleNone;
	[self.layer addSublayer:ly];

	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.textColorMain;

	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;
	self.rightView = nil;
	return self;
}


- (UITextField *)styleLineDisabled {
	[self styleLine:UIColor.whiteColor];
	self.textColorAlternate;
	return self;
}


- (UITextField *)styleLineNormal {
	[self styleLine:Colors.borderNormal];
	return self;
}

- (UITextField *)styleLineActive {
	[self styleLine:Colors.borderActive];
	return self;
}

- (UITextField *)styleLineError {
	[self styleLine:Colors.borderError];
	return self;
}

- (UITextField *)styleLineSuccess {
	[self styleLine:Colors.borderSuccess];
	return self;
}


@end