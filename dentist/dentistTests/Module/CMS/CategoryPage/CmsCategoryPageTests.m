//
//  CmsCategoryPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/11/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsCategoryPage.h"

SPEC_BEGIN(CmsCategoryPageTests)
describe(@"Unit Test For CmsCategoryPage", ^{
    __block CmsCategoryPage *page;

    beforeEach(^{
        page = [CmsCategoryPage new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            [page viewWillAppear:TRUE];
            [[theValue(page.view) shouldNot] beNil];
        });

    });
});
SPEC_END
