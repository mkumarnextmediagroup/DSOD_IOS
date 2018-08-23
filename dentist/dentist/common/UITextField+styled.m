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

- (void)rounded {
	self.borderStyle = UITextBorderStyleRoundedRect;
	self.layer.borderColor = Colors.borderNormal.CGColor;
	self.layer.borderWidth = 1;
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = YES;

	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	[self textColorMain];

	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)backColor {
//    self.borderStyle = UITextBorderStyleRoundedRect;
//    self.layer.borderColor = Colors.borderNormal.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = UIColor.whiteColor;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self textColorMain];
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 10)];
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)themeDisabled {
	if (self.borderStyle == UITextBorderStyleNone) {
		[self themeLineDisabled];
	} else {
		self.layer.borderColor = Colors.bgDisabled.CGColor;
		self.backgroundColor = Colors.bgDisabled;
	}
}


- (void)themeNormal {
	if (self.borderStyle == UITextBorderStyleNone) {
		[self themeLineNormal];
	} else {
		self.layer.borderColor = Colors.borderNormal.CGColor;
		self.backgroundColor = UIColor.whiteColor;
		if (self.rightView != nil) {
			if ([self.rightView isKindOfClass:[UIImageView class]]) {
				self.rightView = nil;
			}
		}
	}
}

- (void)themeActive {
	if (self.borderStyle == UITextBorderStyleNone) {
		[self themeLineActive];
	} else {
		self.layer.borderColor = Colors.borderActive.CGColor;
		self.backgroundColor = UIColor.whiteColor;
		if (self.rightView != nil) {
			if ([self.rightView isKindOfClass:[UIImageView class]]) {
				self.rightView = nil;
			}
		}
	}
}

- (void)stylePassword {
	self.clearButtonMode = UITextFieldViewModeNever;
	[self setSecureTextEntry:YES];
	UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
	[b title:localStr(@"show")];
	[b setTitleColor:Colors.secondary forState:UIControlStateNormal];
	b.titleLabel.font = [Fonts semiBold:12];
	b.frame = makeRect(0, 0, 60, 30);
	self.rightView = b;
	self.rightViewMode = UITextFieldViewModeAlways;
	[b onClick:self action:@selector(_onClickPasswordRightButton:)];
}

- (void)_onClickPasswordRightButton:(UIButton *)sender {
	sender.selected = !sender.isSelected;
	if (sender.isSelected) {
		[self setSecureTextEntry:NO];
		[sender title:localStr(@"hide")];
	} else {
		[self setSecureTextEntry:YES];
		[sender title:localStr(@"show")];
	}
	NSString *s = self.text;
	self.text = @"";
	self.text = s;
}


- (void)themeError {

	if (self.borderStyle == UITextBorderStyleNone) {
		[self themeLineError];
	} else {
		self.layer.borderColor = Colors.borderError.CGColor;
		self.backgroundColor = UIColor.whiteColor;
		if (self.rightView == nil || [self.rightView isKindOfClass:[UIImageView class]]) {
			UIImage *img = [UIImage imageNamed:@"error"];
			UIImageView *iv = [[UIImageView alloc] initWithImage:img];
			iv.tag = TAG_ERROR_SUCCESS;
			[iv alignLeft];
			iv.frame = makeRect(0, 0, 30, 30);
			self.rightView = iv;
			self.rightViewMode = UITextFieldViewModeUnlessEditing;
		}
	}

}

- (void)themeSuccess {
	if (self.borderStyle == UITextBorderStyleNone) {
		[self themeLineSuccess];
	} else {
		self.layer.borderColor = Colors.borderSuccess.CGColor;
		self.backgroundColor = UIColor.whiteColor;

		if (self.rightView == nil || [self.rightView isKindOfClass:[UIImageView class]]) {
			UIImage *img = [UIImage imageNamed:@"ok"];
			UIImageView *iv = [[UIImageView alloc] initWithImage:img];
			iv.tag = TAG_ERROR_SUCCESS;
			[iv alignLeft];
			iv.frame = makeRect(0, 0, 30, 30);
			self.rightView = iv;
			self.rightViewMode = UITextFieldViewModeUnlessEditing;
		}
	}
}


- (void)styleLine {
	CALayer *ly = CALayer.layer;
	ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
	ly.backgroundColor = Colors.borderNormal.CGColor;
	[self.layer addSublayer:ly];

	[self textColorMain];

	self.borderStyle = UITextBorderStyleNone;
	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;
}


- (void)themeLineDisabled {
	NSArray<CALayer *> *ar = self.layer.sublayers;
	if (ar != nil && ar.count > 0) {
		CALayer *ly = ar[ar.count - 1];
		ly.backgroundColor = Colors.bgDisabled.CGColor;
	} else {
		CALayer *ly = CALayer.layer;
		ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
		ly.backgroundColor = Colors.bgDisabled.CGColor;
		[self.layer addSublayer:ly];
	}
	[self textColorAlternate];
}


- (void)themeLineNormal {
	NSArray<CALayer *> *ar = self.layer.sublayers;
	if (ar != nil && ar.count > 0) {
		CALayer *ly = ar[ar.count - 1];
		ly.backgroundColor = Colors.borderNormal.CGColor;
	} else {
		CALayer *ly = CALayer.layer;
		ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
		ly.backgroundColor = Colors.borderNormal.CGColor;
		[self.layer addSublayer:ly];
	}
	[self textColorMain];
}

- (void)themeLineActive {
	NSArray<CALayer *> *ar = self.layer.sublayers;
	if (ar != nil && ar.count > 0) {
		CALayer *ly = ar[ar.count - 1];
		ly.backgroundColor = Colors.borderActive.CGColor;
	} else {
		CALayer *ly = CALayer.layer;
		ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
		ly.backgroundColor = Colors.borderActive.CGColor;
		[self.layer addSublayer:ly];
	}
	[self textColorMain];
}

- (void)themeLineError {
	NSArray<CALayer *> *ar = self.layer.sublayers;
	if (ar != nil && ar.count > 0) {
		CALayer *ly = ar[ar.count - 1];
		ly.backgroundColor = Colors.borderError.CGColor;
	} else {
		CALayer *ly = CALayer.layer;
		ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
		ly.backgroundColor = Colors.borderError.CGColor;
		[self.layer addSublayer:ly];
	}
	[self textColorMain];
}

- (void)themeLineSuccess {
	NSArray<CALayer *> *ar = self.layer.sublayers;
	if (ar != nil && ar.count > 0) {
		CALayer *ly = ar[ar.count - 1];
		ly.backgroundColor = Colors.borderSuccess.CGColor;
	} else {
		CALayer *ly = CALayer.layer;
		ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
		ly.backgroundColor = Colors.borderSuccess.CGColor;
		[self.layer addSublayer:ly];
	}
	[self textColorMain];
}


- (void)returnDone {
	self.returnKeyType = UIReturnKeyDone;
}

- (void)returnNext {
	self.returnKeyType = UIReturnKeyNext;
}

- (void)returnGo {
	self.returnKeyType = UIReturnKeyGo;
}

- (void)returnSearch {
	self.returnKeyType = UIReturnKeySearch;
}

- (void)returnJoin {
	self.returnKeyType = UIReturnKeyJoin;
}

- (void)returnDefault {
	self.returnKeyType = UIReturnKeyDefault;
}

- (void)returnSend {
	self.returnKeyType = UIReturnKeySend;
}

- (void)returnContinue {
	self.returnKeyType = UIReturnKeyContinue;
}

- (void)keyboardDefault {
	self.keyboardType = UIKeyboardTypeDefault;
}

- (void)keyboardPhone {
	self.keyboardType = UIKeyboardTypePhonePad;
}

- (void)keyboardNumber {
	self.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)keyboardNumberAndPun {
	self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

- (void)keyboardUrl {
	self.keyboardType = UIKeyboardTypeURL;
}

- (void)keyboardEmail {
	self.keyboardType = UIKeyboardTypeEmailAddress;
}

- (void)keyboardDecimal {
	self.keyboardType = UIKeyboardTypeDecimalPad;
}


@end
