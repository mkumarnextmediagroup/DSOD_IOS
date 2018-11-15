//
//  ColorTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/12/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "Colors.h"
#import "UIUtil.h"

SPEC_BEGIN(ColorTests)

describe(@"Unit Test for Colors in Common", ^{
    context(@"Properties", ^{
        it(@"Strokes Color", ^{
            UIColor *color = Colors.strokes;
            [[color shouldNot] beNil];
        });

        it(@"Success Color", ^{
            UIColor *color = Colors.success;
            [[color shouldNot] beNil];
        });

        it(@"Error Color", ^{
            UIColor *color = Colors.error;
            [[color shouldNot] beNil];
        });

        it(@"Alert Color", ^{
            UIColor *color = Colors.alert;
            [[color shouldNot] beNil];
        });

        it(@"TextContent Color", ^{
            UIColor *color = Colors.textContent;
            [[color shouldNot] beNil];
        });

        it(@"BorderSuccess Color", ^{
            UIColor *color = Colors.borderSuccess;
            [[color shouldNot] beNil];
        });

        it(@"BorderActive Color", ^{
            UIColor *color = Colors.borderActive;
            [[color shouldNot] beNil];
        });

        it(@"bgColorNor Color", ^{
            UIColor *color = Colors.bgColorNor;
            [[color shouldNot] beNil];
        });

        it(@"bgColorUnite Color", ^{
            UIColor *color = Colors.bgColorUnite;
            [[color shouldNot] beNil];
        });
    });
});

SPEC_END
