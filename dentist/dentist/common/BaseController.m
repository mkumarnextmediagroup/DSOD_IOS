//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseController.h"
#import "UITextField+styled.h"
#import "Common.h"


@implementation BaseController {

}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view onClickView:self action:@selector(_onClickControllerView:)];
}

- (void)_onClickControllerView:(UIView *)sender {
	[self.view endEditing:YES];
}

- (void)dismiss {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openPage:(UIViewController *)c {
	[self presentViewController:c animated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"begin editing");
	[textField themeActive];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"end  editing");
	[textField themeNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.returnKeyType == UIReturnKeyNext) {
		UITextField *ed = [self _findNextEdit:textField];
		if (ed != nil) {
			ed.becomeFirstResponder;
		} else {
			[textField resignFirstResponder];
		}
	} else {
		[textField resignFirstResponder];
		[self onTextFieldDone:textField];
	}
	return YES;
}

- (void)onTextFieldDone:(UITextField *)textField {

}

- (UITextField *)_findNextEdit:(UITextField *)edit {
	CGRect rect = edit.toScreenFrame;
	NSMutableArray *ls = [NSMutableArray arrayWithCapacity:6];
	[self _findAllEdit:self.view array:ls];
	UITextField *nearEdit = nil;
	CGFloat spaceY = 10000;
	for (int i = 0; i < ls.count; ++i) {
		UITextField *ed = ls[i];
		if (ed != edit) {
			CGRect r = ed.toScreenFrame;
			CGFloat ySpace = r.origin.y - rect.origin.y;
			if (ySpace >= 0) {
				if (ySpace < spaceY) {
					nearEdit = ed;
					spaceY = ySpace;
				}
			}
		}
	}
	return nearEdit;

}

- (void)_findAllEdit:(UIView *)currentView array:(NSMutableArray *)array {
	if (currentView == nil) {
		return;
	}
	NSArray *ar = currentView.subviews;
	if (ar != nil) {
		for (int i = 0; i < ar.count; ++i) {
			UIView *child = ar[i];
			if ([child isKindOfClass:[UITextField class]]) {
				[array addObject:child];
			} else {
				[self _findAllEdit:child array:array];
			}
		}
	}
}
@end