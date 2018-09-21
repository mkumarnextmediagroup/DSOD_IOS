//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+styled.h"
#import "Colors.h"
#import "NSMutableAttributedString+customed.h"
#import "Fonts.h"
#import "Common.h"
#import "MyStyle.h"


static char maxLengthAttr = 0;

@implementation UITextField (styled)

- (NSInteger)maxLength {
	NSNumber *v = objc_getAssociatedObject(self, &maxLengthAttr);
	if (v == nil) {
		return 0;
	}
	return v.integerValue;
}


- (void)setMaxLength:(NSInteger)len {
	objc_setAssociatedObject(self, &maxLengthAttr, @(len), OBJC_ASSOCIATION_COPY);
}

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

- (void)textColorBlack {
	self.textColor = UIColor.blackColor;
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

- (void)applyStyleTheme {
	self.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.autocorrectionType = UITextAutocorrectionTypeNo;
	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;

	if (self.style.subStyle == EDIT_SUBSTYLE_SEARCH) {
		UIButton *iv = [UIButton new];
		[iv setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
		iv.frame = CGRectMake(0, 0, 30, 36);
		iv.userInteractionEnabled = NO;
		self.leftView = iv;
	}


	switch (self.style.style) {
		case EDIT_STYLE_NONE:
			break;
		case EDIT_STYLE_ROUNDED:
			[self applyRoundTheme];
			break;
		case EDIT_STYLE_LINED:
			[self applyLineTheme];
			break;
		default:
			break;
	}
}

- (void)applyLineTheme {
	self.borderStyle = UITextBorderStyleNone;
	self.backgroundColor = UIColor.whiteColor;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
	self.leftViewMode = UITextFieldViewModeAlways;

	CALayer *ly = nil;
	NSArray<CALayer *> *ar = self.layer.sublayers;
	if (ar != nil && ar.count > 0) {
		ly = ar[ar.count - 1];
	} else {
		ly = CALayer.layer;
		ly.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
		[self.layer addSublayer:ly];
	}
	ly.backgroundColor = Colors.borderNormal.CGColor;
	[self textColorMain];
	switch (self.style.theme) {
		case EDIT_THEME_ACTIVE:
			ly.backgroundColor = Colors.borderActive.CGColor;
			break;
		case EDIT_THEME_DISABLED:
			ly.backgroundColor = Colors.bgDisabled.CGColor;
			[self textColorAlternate];
			break;
		case EDIT_THEME_ERROR:
			ly.backgroundColor = Colors.borderError.CGColor;
			break;
		case EDIT_THEME_SUCCESS:
			ly.backgroundColor = Colors.borderSuccess.CGColor;
			break;
		default:
			break;
	}
}

- (void)applyRoundTheme {
	if (self.rightView != nil) {
		if ([self.rightView isKindOfClass:[UIImageView class]]) {
			self.rightView = nil;
		}
	}
	self.layer.borderColor = Colors.borderNormal.CGColor;
	self.backgroundColor = UIColor.whiteColor;
	self.borderStyle = UITextBorderStyleRoundedRect;
	self.layer.borderWidth = 1;
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = YES;
	self.clearButtonMode = UITextFieldViewModeWhileEditing;
	[self textColorMain];

	if (self.style.subStyle == EDIT_SUBSTYLE_SEARCH) {
		self.layer.cornerRadius = 8;
	}

	if (self.style.subStyle == EDIT_SUBSTYLE_PWD) {
		self.clearButtonMode = UITextFieldViewModeNever;
		[self setSecureTextEntry:YES];
		UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
		[b title:localStr(@"show")];
		[b setTitleColor:Colors.secondary forState:UIControlStateNormal];
		b.titleLabel.font = [Fonts semiBold:12];
		[b.titleLabel wordSpace:-0.2f];
		b.frame = makeRect(0, 0, 60, 30);
		self.rightView = b;
		self.rightViewMode = UITextFieldViewModeAlways;
		[b onClick:self action:@selector(_onClickPasswordRightButton:)];
	}


	switch (self.style.theme) {
		case EDIT_THEME_NORMAL:
			if (self.style.subStyle == EDIT_SUBSTYLE_GRAY || self.style.subStyle == EDIT_SUBSTYLE_SEARCH) {
				self.layer.borderColor = rgb255(247, 247, 247).CGColor;
				self.backgroundColor = rgb255(247, 247, 247);
			}
			break;
		case EDIT_THEME_ACTIVE:
			self.layer.borderColor = Colors.borderActive.CGColor;
			self.backgroundColor = UIColor.whiteColor;
			break;
		case EDIT_THEME_DISABLED:
			self.layer.borderColor = Colors.bgDisabled.CGColor;
			self.backgroundColor = Colors.bgDisabled;
			break;
		case EDIT_THEME_SUCCESS:
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
			break;
		case EDIT_THEME_ERROR:
			self.layer.borderColor = Colors.borderError.CGColor;
			self.backgroundColor = UIColor.whiteColor;
			if (self.rightView == nil || [self.rightView isKindOfClass:[UIImageView class]]) {
				NSString *imgName = @"error";
				if (self.style.subStyle == EDIT_SUBSTYLE_GRAY) {
					imgName = @"error_red";
				}
				UIImage *img = [UIImage imageNamed:imgName];
				UIImageView *iv = [[UIImageView alloc] initWithImage:img];
				iv.tag = TAG_ERROR_SUCCESS;
				[iv alignLeft];
				iv.frame = makeRect(0, 0, 30, 30);
				self.rightView = iv;
				self.rightViewMode = UITextFieldViewModeUnlessEditing;
			}

			break;
		default:
			break;
	}
}

- (void)styleLined {
	self.style.style = EDIT_STYLE_LINED;
	self.style.subStyle = EDIT_SUBSTYLE_NONE;
	self.style.theme = EDIT_THEME_NORMAL;
	[self applyStyleTheme];
}


- (void)styleRounded {
	self.style.style = EDIT_STYLE_ROUNDED;
	self.style.subStyle = EDIT_SUBSTYLE_NONE;
	self.style.theme = EDIT_THEME_NORMAL;
	[self applyStyleTheme];
}

- (void)styleRoundedGray {
	self.style.style = EDIT_STYLE_ROUNDED;
	self.style.subStyle = EDIT_SUBSTYLE_GRAY;
	self.style.theme = EDIT_THEME_NORMAL;
	[self applyStyleTheme];
}

- (void)styleSearch {
	self.style.style = EDIT_STYLE_ROUNDED;
	self.style.subStyle = EDIT_SUBSTYLE_SEARCH;
	self.style.theme = EDIT_THEME_NORMAL;
	self.font = [Fonts regular:15];
	self.placeholder = @"Search ...";
	[self returnSearch];
	[self applyStyleTheme];
}

- (void)stylePassword {
	self.style.style = EDIT_STYLE_ROUNDED;
	self.style.subStyle = EDIT_SUBSTYLE_PWD;
	self.style.theme = EDIT_THEME_NORMAL;
	[self applyStyleTheme];
}

- (void)themeDisabled {
	self.style.theme = EDIT_THEME_DISABLED;
	[self applyStyleTheme];
}

- (void)themeActive {
	self.style.theme = EDIT_THEME_ACTIVE;
	[self applyStyleTheme];
}

- (void)themeError {
	self.style.theme = EDIT_THEME_ERROR;
	[self applyStyleTheme];
}

- (void)themeSuccess {
	self.style.theme = EDIT_THEME_SUCCESS;
	[self applyStyleTheme];
}

- (void)themeNormal {
	self.style.theme = EDIT_THEME_NORMAL;
	[self applyStyleTheme];
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


- (NSString *)textTrimed {
	return [self.text trimed];
};

@end
