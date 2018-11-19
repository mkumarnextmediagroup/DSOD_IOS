//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (customed)


- (CGFloat)heightThatFit;

- (CGFloat)widthThatFit;

- (void)underLineSingle;

- (void)textColorWhite;

- (void)textColorBlack;

- (void)textColorMain;

- (void)textColorPrimary;

- (void)textColorSecondary;

- (void)textColorAlternate;

- (void)textAlignCenter;

- (void)textAlignLeft;

- (void)textAlignRight;

- (void)lineSpace:(CGFloat)space;

- (void)wordSpace:(CGFloat)f;

- (void)setTextWithDifColor:(NSString *)text;//set different color

- (void)itemTitleStyle;

- (void)itemPrimaryStyle;

- (void)onClick:(id)target action:(SEL)action;
@end
