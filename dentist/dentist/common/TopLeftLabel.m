//
//  TopLeftLabel.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/12.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "TopLeftLabel.h"

@implementation TopLeftLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}
-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
