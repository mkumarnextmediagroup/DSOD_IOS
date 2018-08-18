//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface MASConstraintMaker (myextend)

- (MASConstraintMaker *)widthFit;

- (MASConstraintMaker *)heightFit;

- (MASConstraintMaker *)sizeFit;

- (MASConstraintMaker *)sizeEq:(CGFloat)w h:(CGFloat)h;

- (MASConstraintMaker *)widthEq:(CGFloat)w;

- (MASConstraintMaker *)heightEq:(CGFloat)h;


- (MASConstraintMaker *)fillXParent:(CGFloat)offsetLeft offsetRight:(CGFloat)offsetRight;

- (MASConstraintMaker *)fillYParent:(CGFloat)offsetTop offsetBottom:(CGFloat)offsetBottom;

- (MASConstraintMaker *)topParent:(CGFloat)offset;

- (MASConstraintMaker *)leftParent:(CGFloat)offset;

- (MASConstraintMaker *)rightParent:(CGFloat)offset;

- (MASConstraintMaker *)bottomParent:(CGFloat)offset;

- (MASConstraintMaker *)centerXParent:(CGFloat)offset;

- (MASConstraintMaker *)centerYParent:(CGFloat)offset;

- (MASConstraintMaker *)centerParent;


- (MASConstraintMaker *)widthOf:(UIView *)v;

- (MASConstraintMaker *)heightOf:(UIView *)v;

- (MASConstraintMaker *)topOf:(UIView *)v;

- (MASConstraintMaker *)bottomOf:(UIView *)v;

- (MASConstraintMaker *)leftOf:(UIView *)v;

- (MASConstraintMaker *)rightOf:(UIView *)v;


- (MASConstraintMaker *)above:(UIView *)v offset:(CGFloat)offset;

- (MASConstraintMaker *)below:(UIView *)v offset:(CGFloat)offset;

- (MASConstraintMaker *)toLeftOf:(UIView *)v offset:(CGFloat)offset;

- (MASConstraintMaker *)toRightOf:(UIView *)v offset:(CGFloat)offset;

- (MASConstraintMaker *)centerYOf:(UIView *)v offset:(CGFloat)offset;

- (MASConstraintMaker *)centerXOf:(UIView *)v offset:(CGFloat)offset;

@end