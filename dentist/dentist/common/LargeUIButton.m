//
//  LargeUIButton.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "LargeUIButton.h"

@implementation LargeUIButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //扩大原热区直径至26，可以暴露个接口，用来设置需要扩大的半径。
    CGFloat widthDelta = MAX(40, 0);
    CGFloat heightDelta = MAX(40, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
