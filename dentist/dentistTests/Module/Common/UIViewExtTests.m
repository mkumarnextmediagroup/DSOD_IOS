//
//  UIViewExtTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "Common.h"
#import "UIView+customed.h"
#import "Common.h"

SPEC_BEGIN(UIViewExtTests)
describe(@"Unit Test For UIView Extension", ^{
    __block UIView *v;

    beforeEach(^{
        v = [UIView new];
    });
    context(@"Properties", ^{
        it(@"argObject", ^{
            v.argObject = @"argObject";
            [[theValue(v.argObject) should] equal: theValue(@"argObject")];
        });
    });

    context(@"Methods", ^{
        it(@"toScreenFrame", ^{
            CGRect r = [v toScreenFrame];
            [[theValue(CGRectZero) should] equal: theValue(r)];
        });

        it(@"createSearchBar", ^{
            UISearchBarView *searchBar = [v createSearchBar];
            CGRect fr = CGRectMake(0, NAVHEIGHT, SCREENWIDTH, 57);
            [[theValue(fr) should] equal: theValue(searchBar.frame)];
        });
    });
});
SPEC_END
