//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseController.h"
#import "UITextField+styled.h"
#import "Common.h"
#import "AppDelegate.h"

@implementation BaseController {

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.presentingController = self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view onClickView:self action:@selector(_onClickControllerView:)];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self setupKeyboardMgr];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self uninstallKeyboardMgr];
}

- (void)uninstallKeyboardMgr {
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupKeyboardMgr {
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)n {
	UITextField *ed = [self _findActiveEdit];
	if (ed == nil) {
		return;
	}
	CGRect kbFrame = [n.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGFloat offset = (ed.frame.origin.y + ed.frame.size.height - kbFrame.origin.y + 10);
	double duration = [n.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	if (offset > 0) {
		[UIView animateWithDuration:duration animations:^{
			self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
		}];
	}

}

- (void)keyboardWillHide:(NSNotification *)n {
	double duration = [n.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	[UIView animateWithDuration:duration animations:^{
		self.view.frame = self.view.bounds;
	}];

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

- (void)onTextFieldDone:(UITextField *)textField {

}

- (UITextField *)_findActiveEdit {
	NSMutableArray *ls = [NSMutableArray arrayWithCapacity:6];
	[self _findAllEdit:self.view array:ls];
	for (int i = 0; i < ls.count; ++i) {
		UITextField *ed = ls[i];
		if (ed.isEditing) {
			return ed;
		}
	}
	return nil;
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

- (void)setTopTitle:(NSString *)title bgColor:(UIColor *)bgColor imageName:(UIImage *)imageName {
	UIView *topVi = [UIView new];
	topVi.frame = CGRectMake(0, 0, SCREENWIDTH, NAVHEIGHT);
	topVi.backgroundColor = bgColor;
	[self.view addSubview:topVi];

	UILabel *content = [UILabel new];
	content.font = [UIFont systemFontOfSize:19];
    content.textColor = [UIColor blackColor];
	content.text = title;
	content.textAlignment = NSTextAlignmentCenter;
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

- (void)dismissBtnClick {
	[self dismiss];
}

- (void) leftBtnClick {
   NSLog(@"leftBtn click");
   
}

- (void) rightBtnClick {
    NSLog(@"rightBtn click");
   
}

- (void)setTopTitle:(NSString *)title leftImageName:(UIImage *)imageName
     rightImageName:(UIImage *)rightImageName rightTitle:(NSString *)rightTitle {
    
    UIView *topVi = [UIView new];
    topVi.frame = CGRectMake(0, 0, SCREENWIDTH, NAVHEIGHT);
    topVi.backgroundColor =  [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1/1.0];
    [self.view addSubview:topVi];
    
    UILabel *content = topVi.addLabel;
    content.font = [Fonts semiBold:15];
    content.textColor = [UIColor whiteColor];
    content.text = title;
    content.textAlignment = NSTextAlignmentCenter;
    [[[[[content layoutMaker] sizeFit] centerXParent:0] centerYParent:0] install];
    
    
    UIButton *leftBtn = topVi.addButton;
    [leftBtn setImage:imageName forState:UIControlStateNormal];
    [[[[[leftBtn layoutMaker] sizeFit] centerYParent:0] leftParent:16] install];
   
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *rightBtn =topVi.addButton;
    [rightBtn setImage:imageName forState:UIControlStateNormal];
    [[[[[rightBtn layoutMaker] sizeFit] centerYParent:0] rightParent:17.4] install];

    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *rightLabel = topVi.addLabel;
    rightLabel.font = [Fonts semiBold:15];
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.text = title;
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [[[[[content layoutMaker] sizeFit] centerYParent:0] toRightOf:rightBtn offset:10.5] install];
   
    
}

@end
