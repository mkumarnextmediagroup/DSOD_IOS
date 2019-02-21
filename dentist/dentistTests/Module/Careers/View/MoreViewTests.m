//
//  MoreViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/18/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "MoreView.h"

SPEC_BEGIN(MoreViewTests)
describe(@"Unit Test For MoreView", ^{
    __block MoreView *view;

    beforeEach(^{
        view = [MoreView new];
    });

    context(@"methods", ^{
        it(@"showFuntionBtn", ^{
            [view showFuntionBtn];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"hideFuntionBtn", ^{
            [view hideFuntionBtn];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initSliderView", ^{
            view = [MoreView initSliderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initSubView", ^{
            [view initSubView];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
