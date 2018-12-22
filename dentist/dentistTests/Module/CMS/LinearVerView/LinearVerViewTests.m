//
//  LinearVerViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "LinearVerView.h"
#import "LayoutParam.h"
#import "Common.h"

SPEC_BEGIN(LinearVerViewTests)
describe(@"Unit Test For LinearVerView", ^{
    __block LinearVerView *view;

    beforeEach(^{
        view = [LinearVerView new];
    });

    context(@"methods", ^{
        it(@"layoutSubviews", ^{
            [view addSubview:[UIView new]];
            [view layoutSubviews];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"layoutSubviews", ^{
            UIView *v = [UIView new];
            v.layoutParam.height = -1;
            [view addSubview:v];
            [view layoutSubviews];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"layoutSubviews", ^{
            UIView *v = [UIView new];
            v.layoutParam.height = -2;
            [view addSubview:v];
            [view layoutSubviews];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"layoutSubviews", ^{
            UIView *v = [UIView new];
            [v addSubview:[UIView new]];
            v.layoutParam.height = -1;
            [view addSubview:v];
            [view layoutSubviews];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"observeValueForKeyPath", ^{
            [view observeValueForKeyPath:@"text" ofObject:[UILabel new] change:@{} context:NULL];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
