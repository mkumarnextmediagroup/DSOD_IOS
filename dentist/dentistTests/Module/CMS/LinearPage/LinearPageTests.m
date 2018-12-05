//
//  LinearPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/3/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "LinearPage.h"

SPEC_BEGIN(LinearPageTests)
describe(@"Unit Test For LinearPage", ^{
    __block LinearPage *page;

    beforeEach(^{
        page = [LinearPage new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [page viewDidLoad];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"clickHello", ^{
            // Empty methods
            [page clickHello: NULL];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
