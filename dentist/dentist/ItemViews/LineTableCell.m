//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "LineTableCell.h"
#import "Colors.h"


@implementation LineTableCell {

}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(context, Colors.strokes.CGColor);
	CGFloat left = self.separatorInset.left;
	CGFloat right = self.separatorInset.right;
	CGContextStrokeRect(context, CGRectMake(left + 1, (CGFloat) (rect.size.height - 0.5), rect.size.width - left - right, 1));
}


@end