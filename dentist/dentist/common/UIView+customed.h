//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#import "UISearchBarView.h"

@class LayoutParam;
@class Padding;
@class MyStyle;

@interface UIView (customed)

@property MyStyle *style;

@property Padding *padding;

@property LayoutParam *layoutParam;

- (CGRect)toScreenFrame;

- (void)onClickView:(id)target action:(SEL)action;

- (UISearchBarView *)createSearchBar;

- (UIView *)addView;

- (UILabel *)addLabel;

- (UITextView *)noticeLabel;

- (UITextField *)addEditRaw;

- (UITextField *)addEditRounded;

- (UITextField *)addEditRoundedGray;

- (UITextField *)addEditLined;

- (UITextField *)addEditPwd;
- (UITextField *)addEditSearch;

- (UIButton *)addButton;

- (UIButton *)needHelpBtn;

- (UIButton *)retryBtn;

- (UIButton *)contactButton;

- (UIButton *)resetButton;

- (UIImageView *)addImageView;

- (UITextView *)addTextView;

- (UIButton *)addCheckbox;
- (UIButton *)addSmallButton;


@property(readonly) MASConstraintMaker *layoutMaker;

@property(readonly) MASConstraintMaker *layoutRemaker;

@property(readonly) MASConstraintMaker *layoutUpdate;

- (NSArray *)makeLayout:(void (^)(MASConstraintMaker *))block;


- (void)layoutFill;

- (void)layoutCenterXOffsetTop:(CGFloat)width height:(CGFloat)height offset:(CGFloat)offset;

- (void)layoutFillXOffsetCenterY:(CGFloat)height offset:(CGFloat)offset;


@end
