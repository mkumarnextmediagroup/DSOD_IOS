//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIView+customed.h"
#import "Common.h"
#import "TapGesture.h"
#import "Platform.h"


@implementation UIView (customed)


- (void)onClickView:(id)target action:(SEL)action {
	self.userInteractionEnabled = YES;
	TapGesture *t = [[TapGesture alloc] initWithTarget:self action:@selector(_onClickViewCallback:)];
	t.target = target;
	t.action = action;
	[self addGestureRecognizer:t];
}

- (void)_onClickViewCallback:(UITapGestureRecognizer *)recognizer {
	TapGesture *t = (TapGesture *) recognizer;
	objcSendMsg(t.target, t.action, t.view);
}


- (UIView *)addView {
	UIView *v = [UIView new];
	[self addSubview:v];
	v.backgroundColor = UIColor.clearColor;
	return v;
}


- (void)_checkboxClick:(id)sender {
	UIButton *b = sender;
	b.selected = !b.selected;
}

- (UIButton *)addCheckbox {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
	[self addSubview:button];
	[button onClick:self action:@selector(_checkboxClick:)];
	return button;
}


- (UITextView *)addTextView {
	UITextView *v = [UITextView new];
	[self addSubview:v];
	v.backgroundColor = UIColor.clearColor;
	return v;
}

- (UILabel *)addLabel {
	UILabel *lb = [UILabel new];
	lb.backgroundColor = UIColor.clearColor;
	[lb textColorWhite];
	[self addSubview:lb];
	return lb;
}

- (UIImageView *)addImageView {
	UIImageView *imageView = [UIImageView new];
	[self addSubview:imageView];
	return imageView;
}

- (UITextField *)addEdit {
	UITextField *edit = [UITextField new];
	[edit rounded];
	[self addSubview:edit];
	return edit;
}


- (UIButton *)addButton {
	UIButton *button = [UIButton new];
	[button styleWhite];
	[self addSubview:button];
	return button;
}


- (void)layoutCenterXOffsetTop:(CGFloat)width height:(CGFloat)height offset:(CGFloat)offset {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.width.mas_equalTo(width);
		m.height.mas_equalTo(height);
		m.centerX.equalTo(self.superview.mas_centerX);
		m.top.equalTo(self.superview.mas_top).offset(offset);
	}];
}

- (void)layoutCenterXOffsetBottom:(CGFloat)width height:(CGFloat)height offset:(CGFloat)offset {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.width.mas_equalTo(width);
		m.height.mas_equalTo(height);
		m.centerX.equalTo(self.superview.mas_centerX);
		m.bottom.equalTo(self.superview.mas_bottom).offset(-offset);
	}];
}


- (void)layoutFill {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.left.equalTo(self.superview.mas_left);
		m.right.equalTo(self.superview.mas_right);
		m.top.equalTo(self.superview.mas_top);
		m.bottom.equalTo(self.superview.mas_bottom);
	}];
}

- (void)layoutFillXOffsetCenterY:(CGFloat)height offset:(CGFloat)offset {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.left.equalTo(self.superview.mas_left).offset(EDGE);
		m.right.equalTo(self.superview.mas_right).offset(-EDGE);
		m.height.mas_equalTo(height);
		m.centerY.equalTo(self.superview.mas_centerY).offset(offset);
	}];
}

- (void)layoutFillXOffsetTop:(CGFloat)height offset:(CGFloat)offset {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.left.equalTo(self.superview.mas_left).offset(EDGE);
		m.right.equalTo(self.superview.mas_right).offset(-EDGE);
		m.height.mas_equalTo(height);
		m.top.equalTo(self.superview.mas_top).offset(offset);
	}];
}

- (void)layoutFillXOffsetBottom:(CGFloat)height offset:(CGFloat)offset {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.left.equalTo(self.superview.mas_left).offset(EDGE);
		m.right.equalTo(self.superview.mas_right).offset(-EDGE);
		m.height.mas_equalTo(height);
		m.bottom.equalTo(self.superview.mas_bottom).offset(-offset);
	}];
}

- (NSArray *)makeLayout:(void (^)(MASConstraintMaker *))block {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
	block(constraintMaker);
	return [constraintMaker install];
}

- (MASConstraintMaker *)layoutMaker {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	return [[MASConstraintMaker alloc] initWithView:self];
}


@end