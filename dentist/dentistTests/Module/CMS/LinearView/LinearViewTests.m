//
//  LinearViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/20/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "LinearView.h"
#import "Colors.h"
#import "LayoutParam.h"
#import "Common.h"

SPEC_BEGIN(LinearViewTests)
describe(@"Unit Test For LinearView", ^{
    __block LinearView *view;

    beforeEach(^{
        view = [LinearView new];
    });

    context(@"methods", ^{
        it(@"layoutLinearVertial", ^{
            [view addSubview:[UIView new]];
            [view addSubview:[UIView new]];
            [view layoutLinearVertical];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"layoutLinearVertial", ^{
            UIView * v = [UIView new];
            v.layoutParam.height = -1;
            [view addSubview:v];
            [view addSubview:[UIView new]];
            view.layoutParam.height = -1;
            [view layoutLinearVertical];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"addGrayLine", ^{
            UIView *v = [view addGrayLine:10 marginRight:10];
            [[theValue(v.layoutParam.height) should] equal:theValue(1)];
        });
    });
});
SPEC_END
