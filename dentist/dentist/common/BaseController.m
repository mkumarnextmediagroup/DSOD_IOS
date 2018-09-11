//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseController.h"
#import "UITextField+styled.h"
#import "Common.h"
#import "AppDelegate.h"

@implementation BaseController {
	UIView *toastView;
	NSMutableArray *toastArray;
}

- (instancetype)init {
	self = [super init];
	toastView = nil;
	toastArray = [NSMutableArray arrayWithCapacity:8];
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
	delegate.presentingController = self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
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
	CGRect editRect = [ed toScreenFrame];

	CGRect kbFrame = [n.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGFloat offset = (editRect.origin.y + editRect.size.height - kbFrame.origin.y + 10);
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


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[textField themeActive];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
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

- (void)leftBtnClick {
	NSLog(@"leftBtn click");

}

- (void)rightBtnClick {
	NSLog(@"rightBtn click");

}


- (void)toastCenter:(NSString *)text {
	ToastItem *item = [ToastItem new];
	item.text = text;
	item.y = SCREENHEIGHT / 2;
	[toastArray addObject:item];
	[self nextToast];
}

- (void)toastBelow:(UIView *)anchor text:(NSString *)text {
	CGRect r = [anchor toScreenFrame];
	ToastItem *item = [ToastItem new];
	item.text = text;
	item.y = r.origin.y + r.size.height + 15;
	[toastArray addObject:item];
	[self nextToast];
}

- (void)nextToast {
	if (toastArray.count == 0) {
		return;
	}
	if (toastView == nil) {
		ToastItem *item = toastArray[0];
		[toastArray removeObjectAtIndex:0];
		toastView = [self buildToastView:item];
	}

}

- (UIView *)buildToastView:(ToastItem *)item {
	UIView *v = self.view.addView;
	v.backgroundColor = rgba255(94, 110, 122, 100);
	[[[[[[v layoutMaker] leftParent:22] rightParent:-22] topParent:item.y] heightEq:40] install];

	UILabel *lb = v.addLabel;
	lb.text = item.text;
	lb.numberOfLines = 0;
	[lb textColorWhite];
	lb.font = [Fonts regular:10];
	[[[[[lb layoutMaker] sizeFit] leftParent:10] centerYParent:0] install];

	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[v addSubview:btn];
	[btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
	[[[[[btn layoutMaker] sizeEq:40 h:40] rightParent:0] centerYParent:0] install];

	[btn onClick:self action:@selector(clickToastButton:)];

	foreDelay(5000, ^() {
		[self closeToast];
	});

	return v;
}

- (void)clickToastButton:(id)sender {
	[self closeToast];
}

- (void)closeToast {
	[toastView removeFromSuperview];
	toastView = nil;
	foreTask(^() {
		[self nextToast];
	});
}


@end
