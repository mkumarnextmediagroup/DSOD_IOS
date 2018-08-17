//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseController.h"
#import "UITextField+styled.h"
#import "Colors.h"


@implementation BaseController {

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"begin editing");
	if (textField.borderStyle == UITextBorderStyleNone) {
		textField.styleLineActive;
	} else {
		textField.styleActive;
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"end  editing");
	if (textField.borderStyle == UITextBorderStyleNone) {
		textField.styleLineNormal;
	} else {
		textField.styleNormal;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	textField.resignFirstResponder;
	return YES;
}
@end