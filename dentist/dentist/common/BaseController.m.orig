//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseController.h"
#import "UITextField+styled.h"
#import "Common.h"
#import "UIView+customed.h"
#import "UIImageView+customed.h"


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
			[ed becomeFirstResponder];
		} else {
			[textField resignFirstResponder];
		}
	} else {
		[textField resignFirstResponder];
		[self onTextFieldDone:textField];
	}
	return YES;
}

- (void)setTopTitle:(NSString *)title imageName:(UIImage *)imageName
{
    UIView *topVi = [UIView new];
    topVi.frame = CGRectMake(0, 0, SCREENWIDTH, NAVHEIGHT);
    topVi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topVi];
    
    UILabel *content = [UILabel new];
    content.font = [UIFont systemFontOfSize:19];
    content.textColor = [UIColor blackColor];
    content.text = title;
    content.frame = CGRectMake(50, 23, SCREENWIDTH - 100, 40);
    [topVi addSubview:content];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:imageName forState:UIControlStateNormal];
    dismissBtn.frame = CGRectMake(SCREENWIDTH - 60, 24, 60, 40);
    [topVi addSubview:dismissBtn];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(0, NAVHEIGHT - 1.5, SCREENWIDTH, 1.5);
    line.backgroundColor = rgb255(222, 222, 222);
    [topVi addSubview:line];
}

- (void)dismissBtnClick
{
    [self dismiss];
}

@end
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
