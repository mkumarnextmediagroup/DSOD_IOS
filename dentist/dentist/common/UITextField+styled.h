//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (styled)

@property NSString *hint;

- (void)textColorBlack;

- (void)textColorWhite;

- (void)textAlignCenter;

- (void)textAlignLeft;

- (void)textAlignRight;

- (void)textColorMain;

- (void)textColorAlternate;


- (void)styleRounded;

- (void)styleLine;

- (void)themeSuccess;

- (void)themeDisabled;


- (void)themeNormal;

- (void)themeActive;

- (void)themeError;


- (void)resetNormal;

- (void)resetError;


- (void)stylePassword;


- (void)returnDone;

- (void)returnNext;

- (void)returnGo;

- (void)returnSearch;

- (void)returnJoin;

- (void)returnDefault;

- (void)returnSend;

- (void)returnContinue;


- (void)keyboardDefault;

- (void)keyboardPhone;

- (void)keyboardNumber;

- (void)keyboardNumberAndPun;

- (void)keyboardUrl;

- (void)keyboardEmail;

- (void)keyboardDecimal;


@end
