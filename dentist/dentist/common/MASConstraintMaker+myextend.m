//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "MASConstraintMaker+myextend.h"
#import "Common.h"


@implementation MASConstraintMaker (myextend)


- (MASConstraintMaker *)widthFit {
	UIView *view = [self valueForKey:@"view"];
	CGSize sz = [view sizeThatFits:CGSizeZero];
	[self widthEq:sz.width];
	return self;
}

- (MASConstraintMaker *)heightFit {
	UIView *view = [self valueForKey:@"view"];
	CGSize sz = [view sizeThatFits:CGSizeZero];
	[self heightEq:sz.height];
	return self;
}

- (MASConstraintMaker *)sizeFit {
	UIView *view = [self valueForKey:@"view"];
	CGSize sz = [view sizeThatFits:CGSizeZero];
	[self sizeEq:sz.width h:sz.height];
	return self;
}

- (MASConstraintMaker *)sizeEq:(CGFloat)w h:(CGFloat)h {
	self.width.mas_equalTo(w);
	self.height.mas_equalTo(h);
	return self;
}

- (MASConstraintMaker *)widthEq:(CGFloat)w {
	self.width.mas_equalTo(w);
	return self;
}

- (MASConstraintMaker *)widthGe:(CGFloat)w {
	self.width.mas_greaterThanOrEqualTo(w);
	return self;
}

- (MASConstraintMaker *)widthLe:(CGFloat)w {
	self.width.mas_lessThanOrEqualTo(w);
	return self;
}
- (MASConstraintMaker *)heightEdit{
	self.height.mas_equalTo(EDIT_HEIGHT);
	return self;
}
- (MASConstraintMaker *)heightButton{
	self.height.mas_equalTo(BTN_HEIGHT);
	return self;
}
- (MASConstraintMaker *)heightEq:(CGFloat)h {
	self.height.mas_equalTo(h);
	return self;
}

- (MASConstraintMaker *)heightGe:(CGFloat)h {
	self.height.mas_greaterThanOrEqualTo(h);
	return self;
}

- (MASConstraintMaker *)heightLe:(CGFloat)h {
	self.height.mas_lessThanOrEqualTo(h);
	return self;
}

- (MASConstraintMaker *)fillXParent:(CGFloat)offsetLeft offsetRight:(CGFloat)offsetRight {
	[self leftParent:offsetLeft];
	[self rightParent:offsetRight];
	return self;
}

- (MASConstraintMaker *)fillYParent:(CGFloat)offsetTop offsetBottom:(CGFloat)offsetBottom {
	[self topParent:offsetTop];
	[self bottomParent:offsetBottom];
	return self;
}

- (MASConstraintMaker *)topParent:(CGFloat)offset {
	UIView *view = [self valueForKey:@"view"];
	self.top.mas_equalTo(view.superview.mas_top).offset(offset);
	return self;
}

- (MASConstraintMaker *)leftParent:(CGFloat)offset {
	UIView *view = [self valueForKey:@"view"];
	self.left.mas_equalTo(view.superview.mas_left).offset(offset);
	return self;
}

- (MASConstraintMaker *)rightParent:(CGFloat)offset {
	UIView *view = [self valueForKey:@"view"];
	self.right.mas_equalTo(view.superview.mas_right).offset(offset);
	return self;
}

- (MASConstraintMaker *)bottomParent:(CGFloat)offset {
	UIView *view = [self valueForKey:@"view"];
	self.bottom.mas_equalTo(view.superview.mas_bottom).offset(offset);
	return self;
}

- (MASConstraintMaker *)centerXParent:(CGFloat)offset {
	UIView *view = [self valueForKey:@"view"];
	self.centerX.mas_equalTo(view.superview.mas_centerX).offset(offset);
	return self;
}

- (MASConstraintMaker *)centerYParent:(CGFloat)offset {
	UIView *view = [self valueForKey:@"view"];
	self.centerY.mas_equalTo(view.superview.mas_centerY).offset(offset);
	return self;
}

- (MASConstraintMaker *)centerParent {
	UIView *view = [self valueForKey:@"view"];
	self.centerX.mas_equalTo(view.superview.mas_centerX);
	self.centerY.mas_equalTo(view.superview.mas_centerY);
	return self;
}

- (MASConstraintMaker *)widthOf:(UIView *)v {
	self.width.mas_equalTo(v.mas_width);
	return self;
}

- (MASConstraintMaker *)heightOf:(UIView *)v {
	self.height.mas_equalTo(v.mas_height);
	return self;
}

- (MASConstraintMaker *)topOf:(UIView *)v offset:(CGFloat)offset {
	self.top.equalTo(v.mas_top).offset(offset);
	return self;
}

- (MASConstraintMaker *)bottomOf:(UIView *)v offset:(CGFloat)offset {
	self.bottom.equalTo(v.mas_bottom).offset(offset);
	return self;
}

- (MASConstraintMaker *)leftOf:(UIView *)v {
	self.left.mas_equalTo(v.mas_left);
	return self;
}

- (MASConstraintMaker *)rightOf:(UIView *)v {
	self.right.mas_equalTo(v.mas_right);
	return self;
}


- (MASConstraintMaker *)above:(UIView *)v offset:(CGFloat)offset {
	self.bottom.equalTo(v.mas_top).offset(offset);
//	self.bottom.equalTo(v.mas_top).offset(offset);
	return self;
}

- (MASConstraintMaker *)below:(UIView *)v offset:(CGFloat)offset {
	self.top.mas_equalTo(v.mas_bottom).offset(offset);
	return self;
}

- (MASConstraintMaker *)toLeftOf:(UIView *)v offset:(CGFloat)offset {
	self.right.mas_equalTo(v.mas_left).offset(offset);
	return self;
}

- (MASConstraintMaker *)toRightOf:(UIView *)v offset:(CGFloat)offset {
	self.left.mas_equalTo(v.mas_right).offset(offset);
	return self;
}

- (MASConstraintMaker *)centerYOf:(UIView *)v offset:(CGFloat)offset {
	self.centerY.mas_equalTo(v.mas_centerY).offset(offset);
	return self;
}

- (MASConstraintMaker *)centerXOf:(UIView *)v offset:(CGFloat)offset {
	self.centerX.mas_equalTo(v.mas_centerX).offset(offset);
	return self;
}

- (MASConstraintMaker *)fillParent {
	UIView *view = [self valueForKey:@"view"];
	self.edges.equalTo(view);
	return self;
}

@end
