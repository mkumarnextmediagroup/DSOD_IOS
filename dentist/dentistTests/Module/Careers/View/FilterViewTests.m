//
//  FilterViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/16/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "FilterView.h"

SPEC_BEGIN(FilterViewTests)
describe(@"Unit Test For FilterView", ^{
    __block FilterView *view;

    beforeEach(^{
        view = [FilterView new];
    });

    context(@"methods", ^{
        it(@"initFilterView", ^{
            view = [FilterView initFilterView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"showFilter", ^{
            [view showFilter];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
