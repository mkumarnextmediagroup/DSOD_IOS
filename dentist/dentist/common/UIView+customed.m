//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+customed.h"
#import "Common.h"

static char layoutParamAttr = 0;
static char paddingAttr = 0;
static char themeAttr = 0;
static char styleAttr = 0;

@implementation UIView (customed)


- (NSInteger)style {
	NSNumber *v = objc_getAssociatedObject(self, &styleAttr);
	if (v == nil) {
		[self setStyle:0];
		return 0;
	}
	return [v integerValue];
}

- (void)setStyle:(NSInteger)style {
	objc_setAssociatedObject(self, &styleAttr, @(style), OBJC_ASSOCIATION_COPY);
}

- (NSInteger)theme {
	NSNumber *v = objc_getAssociatedObject(self, &themeAttr);
	if (v == nil) {
		[self setTheme:0];
		return 0;
	}
	return [v integerValue];
}

- (void)setTheme:(NSInteger)theme {
	objc_setAssociatedObject(self, &themeAttr, @(theme), OBJC_ASSOCIATION_COPY);
}


- (Padding *)padding {
	Padding *p = objc_getAssociatedObject(self, &paddingAttr);
	if (p == nil) {
		Padding *pp = [Padding new];
		[self setPadding:pp];
		return pp;
	}
	return p;
}

- (void)setPadding:(Padding *)p {
	objc_setAssociatedObject(self, &paddingAttr, p, OBJC_ASSOCIATION_RETAIN);
}


- (LayoutParam *)layoutParam {
	LayoutParam *p = objc_getAssociatedObject(self, &layoutParamAttr);
	if (p == nil) {
		LayoutParam *pp = [LayoutParam new];
		[self setLayoutParam:pp];
		return pp;
	}
	return p;
}

- (void)setLayoutParam:(LayoutParam *)p {
	objc_setAssociatedObject(self, &layoutParamAttr, p, OBJC_ASSOCIATION_RETAIN);
}


- (CGRect)toScreenFrame {
	UIWindow *w = [[UIApplication sharedApplication] keyWindow];
	return [self convertRect:self.bounds toView:w];
}

- (UISearchBarView *)createSearchBar {
	UISearchBarView *searchBarView = [[UISearchBarView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, SCREENWIDTH, 57)];
	[self addSubview:searchBarView];
	return searchBarView;
}

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

- (UIButton *)retryBtn {
	UIButton *needHelpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[needHelpBtn title:localStr(@"Retry")];
	[needHelpBtn styleWhite];
	[self addSubview:needHelpBtn];
	return needHelpBtn;
}

- (UIButton *)needHelpBtn {
	UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[retryButton title:localStr(@"Need help?")];
	[retryButton stylePrimary];
	[self addSubview:retryButton];
	return retryButton;
}

- (UITextView *)addTextView {
	UITextView *v = [UITextView new];
	[self addSubview:v];
	v.backgroundColor = UIColor.clearColor;
	v.editable = NO;
	return v;
}

- (UILabel *)addLabel {
	UILabel *lb = [UILabel new];
	lb.backgroundColor = UIColor.clearColor;
	[lb textColorMain];
	[self addSubview:lb];
	return lb;
}

- (UITextView *)noticeLabel {
	UITextView *noticelb = [UITextView new];
	noticelb.backgroundColor = Colors.secondary;
	noticelb.textColor = UIColor.whiteColor;
	noticelb.tag = 11;
	noticelb.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 15);
	[self addSubview:noticelb];

	UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
	b.frame = makeRect(SCREENWIDTH - 88, 0, 60, BTN_HEIGHT);
	[b setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
	[noticelb addSubview:b];
	[b onClick:self action:@selector(deleteNoticeButton:)];
	return noticelb;
}

- (void)deleteNoticeButton:(UIButton *)btn {
	NSLog(@"delelte");
	[btn removeFromSuperview];
	UITextView *notice = [self viewWithTag:11];
	notice.hidden = YES;
}

- (UIImageView *)addImageView {
	UIImageView *imageView = [UIImageView new];
	[imageView alignCenter];
	[self addSubview:imageView];
	return imageView;
}

- (UITextField *)addEdit {
	UITextField *edit = [UITextField new];
	edit.autocapitalizationType = UITextAutocapitalizationTypeNone;
	edit.autocorrectionType = UITextAutocorrectionTypeNo;
	[edit styleRounded];
	[self addSubview:edit];
	return edit;
}

- (UITextField *)addEditRaw {
	UITextField *edit = [UITextField new];
	edit.autocapitalizationType = UITextAutocapitalizationTypeNone;
	edit.autocorrectionType = UITextAutocorrectionTypeNo;
	[self addSubview:edit];
	return edit;
}

- (UITextField *)resetEdit {
	UITextField *reset = [UITextField new];
	reset.tag = FORGOTFIELDTAG;
	reset.autocapitalizationType = UITextAutocapitalizationTypeNone;
	reset.autocorrectionType = UITextAutocorrectionTypeNo;
	[reset styleRounded];
	[self addSubview:reset];
	return reset;
}

- (UIButton *)addButton {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[self addSubview:button];
	return button;
}

- (UIButton *)resetButton {
	UIButton *button = [UIButton new];
	[button stylePrimary];
	[self addSubview:button];
	return button;
}

- (UIButton *)contactButton {
	NSString *aStr = localStr(@"haveIssue");
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", aStr]];
	[str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 20)];
	[str addAttribute:NSForegroundColorAttributeName value:Colors.primary range:NSMakeRange(20, aStr.length - 20)];

	UIButton *contactBtn = [UIButton new];
	[contactBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
	[contactBtn setTitleColor:Colors.primary forState:UIControlStateNormal];
	[contactBtn setAttributedTitle:str forState:UIControlStateNormal];
	[self addSubview:contactBtn];

	return contactBtn;
}

- (void)layoutCenterXOffsetTop:(CGFloat)width height:(CGFloat)height offset:(CGFloat)offset {
	[self makeLayout:^(MASConstraintMaker *m) {
		m.width.mas_equalTo(width);
		m.height.mas_equalTo(height);
		m.centerX.equalTo(self.superview.mas_centerX);
		m.top.equalTo(self.superview.mas_top).offset(offset);
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

- (MASConstraintMaker *)layoutRemaker {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
	constraintMaker.removeExisting = YES;
	return constraintMaker;
}

- (MASConstraintMaker *)layoutUpdate {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
	constraintMaker.updateExisting = YES;
	return constraintMaker;
}


@end
