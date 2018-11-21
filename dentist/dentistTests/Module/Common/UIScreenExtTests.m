//
//  UIScreenExtTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "Common.h"
#import "UIScreen+customed.h"

SPEC_BEGIN(UIScreenExtTests)
describe(@"Unit Test For UIScreen Extension", ^{
    context(@"Properties", ^{
        it(@"width", ^{
            [[theValue(UIScreen.width) should] equal: theValue(UIScreen.mainScreen.bounds.size.width)];
        });

        it(@"height", ^{
            [[theValue(UIScreen.height) should] equal: theValue(UIScreen.mainScreen.bounds.size.height)];
        });
    });
});

SPEC_END
