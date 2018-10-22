//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+customed.h"
#import "Common.h"
#import "MyStyle.h"
#import "TopLabel.h"

static char layoutParamAttr = 0;
static char paddingAttr = 0;
static char styleAttr = 0;
static char argObjectAttr = 0;

@implementation UIView (customed)

//@property NSObject *argObject


- (NSObject *)argObject {
	return objc_getAssociatedObject(self, &argObjectAttr);
}

- (void)setArgObject:(NSObject *)argObj {
	objc_setAssociatedObject(self, &argObjectAttr, argObj, OBJC_ASSOCIATION_RETAIN);
}


- (MyStyle *)style {
	MyStyle *v = objc_getAssociatedObject(self, &styleAttr);
	if (v == nil) {
		v = [MyStyle new];
		[self setStyle:v];
	}
	return v;
}

- (void)setStyle:(MyStyle *)style {
	objc_setAssociatedObject(self, &styleAttr, style, OBJC_ASSOCIATION_RETAIN);
}


- (Padding *)padding {
	Padding *p = objc_getAssociatedObject(self, &paddingAttr);
	if (p == nil) {
		p = [Padding new];
		[self setPadding:p];
	}
	return p;
}

- (void)setPadding:(Padding *)p {
	objc_setAssociatedObject(self, &paddingAttr, p, OBJC_ASSOCIATION_RETAIN);
}


- (LayoutParam *)layoutParam {
	LayoutParam *p = objc_getAssociatedObject(self, &layoutParamAttr);
	if (p == nil) {
		p = [LayoutParam new];
		[self setLayoutParam:p];
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
	[needHelpBtn stylePrimary];
	[self addSubview:needHelpBtn];
	return needHelpBtn;
}

- (UIButton *)needHelpBtn {
	UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[retryButton title:localStr(@"Need help?")];
	[retryButton styleWhite];
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

- (UILabel *)topShowLabel {
    TopLabel *lb = [TopLabel new];
    lb.numberOfLines = 0;
    [lb setVerticalAlignment:VerticalAlignmentTop];
    lb.backgroundColor = UIColor.clearColor;
    [lb textColorMain];
    [self addSubview:lb];
    return lb;
}

- (UILabel *)addLabel {
	UILabel *lb = [UILabel new];
	lb.numberOfLines = 0;
	lb.backgroundColor = UIColor.clearColor;
	[lb textColorMain];
	[self addSubview:lb];
	return lb;
}

- (UILabel *)lineLabel {
	UILabel *lb = [UILabel new];
	lb.backgroundColor = Colors.strokes;
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
	[notice removeFromSuperview];
}

- (UIImageView *)addImageView {
	UIImageView *imageView = [UIImageView new];
	[imageView alignCenter];
	[self addSubview:imageView];
	return imageView;
}

- (UITextField *)addEditRoundedGray {
	UITextField *reset = [self addEditRaw];
	[reset styleRoundedGray];
	return reset;
}

- (UITextField *)addEditRounded {
	UITextField *edit = [self addEditRaw];
	[edit styleRounded];
	return edit;
}

- (UITextField *)addEditLined {
	UITextField *edit = [self addEditRaw];
	[edit styleLined];
	return edit;
}

- (UITextField *)addEditPwd {
	UITextField *edit = [self addEditRaw];
	[edit stylePassword];
	return edit;
}

- (UITextField *)addEditSearch {
	UITextField *edit = [self addEditRaw];
	[edit styleSearch];
	return edit;
}

- (UITextField *)addEditRaw {
	UITextField *edit = [UITextField new];
	edit.autocapitalizationType = UITextAutocapitalizationTypeNone;
	edit.autocorrectionType = UITextAutocorrectionTypeNo;
	[self addSubview:edit];
	return edit;
}


- (UIButton *)addButton {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[self addSubview:button];
	return button;
}

- (UIScrollView *)addScrollView {
    UIScrollView *scroll = [UIScrollView new];
    [self addSubview:scroll];
    return scroll;
}

- (UIButton *)resetButton {
	UIButton *button = [UIButton new];
	[button stylePrimary];
	[self addSubview:button];
	return button;
}

- (UIButton *)addSmallButton {
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn title:@"Button"];
	[btn setTitleColor:Colors.primary forState:UIControlStateNormal];
	[btn setTitleColor:Colors.buttonPrimaryActive forState:UIControlStateHighlighted];
	btn.titleLabel.font = [Fonts semiBold:15];
	[self addSubview:btn];
	return btn;
}

- (WKWebView *)addWebview{
    WKWebView *webv = [WKWebView new];
    [self addSubview:webv];
    return webv;
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

- (void)layoutRemoveAllConstraints {
	NSArray *installedConstraints = [MASViewConstraint installedConstraintsForView:self];
	for (MASConstraint *constraint in installedConstraints) {
		[constraint uninstall];
	}
}


- (void)removeAllChildren {
	NSArray *arr = self.subviews;
	for (UIView *v in arr) {
		[v removeFromSuperview];
	}
}


- (NSArray *)childrenVisiable {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.subviews.count];
	for (UIView *v in self.subviews) {
		if (!v.hidden) {
			[array addObject:v];
		}
	}
	return array;
}

- (UIView *)grayLineHor:(CGFloat)marginLeft marginRight:(CGFloat)marginRight {
	UIView *v = [UIView new];
	v.layoutParam.height = 1;
	v.layoutParam.marginLeft = marginLeft;
	v.layoutParam.marginRight = marginRight;
	[self addSubview:v];
	v.backgroundColor = Colors.cellLineColor;
	return v;
}

@end
