//
//  FontsTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/15/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "Fonts.h"

SPEC_BEGIN(FontsTests)

describe(@"Unit Test For Fonts", ^{
    context(@"Properties", ^{
        it(@"font for title", ^{
            UIFont *f = Fonts.title;
            [[theValue([f pointSize]) should] equal:theValue(15)];
        });

        it(@"font for heading1", ^{
            UIFont *f = Fonts.heading1;
            [[theValue([f pointSize]) should] equal:theValue(20)];
        });

        it(@"font for heading2", ^{
            UIFont *f = Fonts.heading2;
            [[theValue([f pointSize]) should] equal:theValue(17)];
        });

        it(@"font for body", ^{
            UIFont *f = Fonts.body;
            [[theValue([f pointSize]) should] equal:theValue(13)];
        });

        it(@"font for caption", ^{
            UIFont *f = Fonts.caption;
            [[theValue([f pointSize]) should] equal:theValue(14)];
        });

        it(@"font for tiny", ^{
            UIFont *f = Fonts.tiny;
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });
    });

    context(@"Methors", ^{
        it(@"font for heavy", ^{
            UIFont *f = [Fonts heavy:12];
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });

        it(@"font for bold", ^{
            UIFont *f = [Fonts bold:12];
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });

        it(@"font for semiBold", ^{
            UIFont *f = [Fonts semiBold:12];
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });

        it(@"font for medium", ^{
            UIFont *f = [Fonts medium:12];
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });

        it(@"font for regular", ^{
            UIFont *f = [Fonts regular:12];
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });

        it(@"font for light", ^{
            UIFont *f = [Fonts light:12];
            [[theValue([f pointSize]) should] equal:theValue(12)];
        });
    });
});

SPEC_END
