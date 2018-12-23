//
//  UIViewExtensionTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UIViewExt.h"

SPEC_BEGIN(UIViewExtensionTests)
describe(@"Unit Test For UIViewExt", ^{
    __block UIView *view;

    beforeEach(^{
        view = [UIView new];
        view.frame = CGRectMake(0, 0, 100, 100);
    });

    context(@"properties", ^{
        it(@"origin", ^{
            CGPoint origin = view.origin;
            [[theValue(origin.x) should] equal:theValue(0)];
            [[theValue(origin.y) should] equal:theValue(0)];
        });

        it(@"size", ^{
            CGSize size = view.size;
            [[theValue(size.width) should] equal:theValue(100)];
            [[theValue(size.height) should] equal:theValue(100)];
        });

        it(@"bottomLeft", ^{
            CGPoint bottomLeft = view.bottomLeft;
            [[theValue(bottomLeft.x) should] equal: theValue(0)];
            [[theValue(bottomLeft.y) should] equal: theValue(100)];
        });

        it(@"bottomRight", ^{
            CGPoint bottomRight = view.bottomRight;
            [[theValue(bottomRight.x) should] equal: theValue(100)];
            [[theValue(bottomRight.y) should] equal: theValue(100)];
        });

        it(@"topRight", ^{
            CGPoint topRight = view.topRight;
            [[theValue(topRight.x) should] equal: theValue(100)];
            [[theValue(topRight.y) should] equal: theValue(0)];
        });

        it(@"height", ^{
            CGFloat height = view.height;
            [[theValue(height) should] equal:theValue(100)];
        });

        it(@"width", ^{
            CGFloat width = view.width;
            [[theValue(width) should] equal:theValue(100)];
        });

        it(@"top", ^{
            CGFloat top = view.top;
            [[theValue(top) should] equal:theValue(0)];
        });

        it(@"left", ^{
            CGFloat left = view.left;
            [[theValue(left) should] equal:theValue(0)];
        });

        it(@"bottom", ^{
            CGFloat bottom = view.bottom;
            [[theValue(bottom) should] equal:theValue(100)];
        });

        it(@"right", ^{
            CGFloat right = view.right;
            [[theValue(right) should] equal:theValue(100)];
        });
    });

    context(@"methods", ^{
        it(@"moveBy", ^{
            CGPoint center = view.center;
            CGFloat centerX = center.x;
            CGFloat centerY = center.y;
            [view moveBy:CGPointMake(10, 10)];
            [[theValue(view.center.x) should] equal:theValue(centerX + 10)];
            [[theValue(view.center.y) should] equal:theValue(centerY + 10)];
        });

        it(@"scaleBy", ^{
            CGFloat width = view.width;
            CGFloat height = view.height;
            [view scaleBy:0.5];
            [[theValue(view.width) should] equal:theValue(width * 0.5)];
            [[theValue(view.height) should] equal:theValue(height * 0.5)];
        });

        it(@"fitInSize", ^{
            [view fitInSize:CGSizeMake(10, 10)];
            [[theValue(view.frame) should] equal:theValue(CGRectMake(0, 0, 10, 10))];
        });
    });
});
SPEC_END
