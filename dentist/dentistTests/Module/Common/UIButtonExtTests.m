//
//  UIButtonExtTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "Common.h"
#import "UIButton+styled.h"

SPEC_BEGIN(UIButtonExtTests)
describe(@"Unit Test For UIButton Extension", ^{
    __block UIButton *bt;

    beforeEach(^{
        bt = [UIButton new];
    });

    context(@"Properties", ^{
        it(@"heightPrefer", ^{
            [[theValue(UIButton.heightPrefer) should] equal: theValue(40)];
        });

        it(@"widthLarge", ^{
            [[theValue(UIButton.widthLarge) should] equal: theValue(330)];
        });
    });

    context(@"Methods", ^{
        it(@"styleBlue", ^{
            [bt styleBlue];
            [[theValue([bt titleColorForState:UIControlStateNormal]) should] equal: theValue(UIColor.whiteColor)];
        });

        it(@"stylePrimary", ^{
            [bt stylePrimary];
            [[theValue([bt titleColorForState:UIControlStateNormal]) should] equal: theValue(UIColor.whiteColor)];
        });

        it(@"styleSecondary", ^{
            [bt styleSecondary];
            [[theValue([bt titleColorForState:UIControlStateNormal]) should] equal: theValue(UIColor.whiteColor)];
        });

        it(@"styleWhite", ^{
            [bt styleWhite];
            [[theValue([bt titleColorForState:UIControlStateNormal]) should] equal: theValue(Colors.textMain)];
        });

        it(@"title with text", ^{
            [bt title:@"title"];
            [[[bt titleForState:UIControlStateNormal] should] equal: @"title"];
        });

        it(@"textColorWhite", ^{
            [bt textColorWhite];
            [[theValue([bt titleColorForState:UIControlStateNormal]) should] equal: theValue(UIColor.whiteColor)];
        });
    });
});
SPEC_END
