//
//  XHStarRateViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/26/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "XHStarRateView.h"

SPEC_BEGIN(XHStarRateViewTests)
describe(@"Unit Test For XHStarRateView", ^{
    __block XHStarRateView *view;

    beforeEach(^{
        view = [XHStarRateView new];
    });

    context(@"methods", ^{
        it(@"initWithFrame", ^{
            view = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initWithFrame and numberOfStars", ^{
            view = [[XHStarRateView alloc]
                    initWithFrame:CGRectMake(0, 0, 10, 10)
                    numberOfStars:5 rateStyle:WholeStar isAnination:TRUE delegate:self];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initWithFrame with finish", ^{
            view = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) finish:NULL];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initWithFrame with star, style, animation and finish", ^{
            view = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) numberOfStars:5 rateStyle:WholeStar isAnination:TRUE finish:NULL];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"userTapRateView", ^{
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NULL];
            view.rateStyle = WholeStar;
            [view userTapRateView:tapGesture];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"userTapRateView", ^{
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NULL];
            view.rateStyle = HalfStar;
            [view userTapRateView:tapGesture];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"userTapRateView", ^{
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NULL];
            view.rateStyle = IncompleteStar;
            [view userTapRateView:tapGesture];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"layoutSubviews", ^{
            [view layoutSubviews];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"setCurrentScore", ^{
            view.currentScore = 5;
            [view setCurrentScore:5];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"setCurrentScore", ^{
            [view setCurrentScore:-5];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"setCurrentScore", ^{
            [view setCurrentScore:6];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
