//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (customed)


-(void)wordSpace:(CGFloat) f ;

- (void)paragraphStyle:(NSMutableParagraphStyle *)ps;

- (void)underlineSingle;

- (void)foreColor:(UIColor *)color;

- (void)backColor:(UIColor *)color;

- (void)font:(UIFont *)font;


- (void)setAttr:(NSAttributedStringKey)name value:(id)value;
- (id)attr:(NSAttributedStringKey)name;

@end