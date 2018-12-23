//
//  RMDownloadIndicatorTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "RMDownloadIndicator.h"

SPEC_BEGIN(RMDownloadIndicatorTests)
describe(@"Unit Test For RMDownloadIndicator", ^{
    __block RMDownloadIndicator *indicator;

    beforeEach(^{
        indicator = [RMDownloadIndicator new];
    });

    context(@"methods", ^{
        it(@"init with kRMClosedIndicator", ^{
            indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(0, 0, 20, 20) type:kRMClosedIndicator];
            [[theValue(indicator) shouldNot] beNil];
        });

        it(@"init with kRMMixedIndicator", ^{
            indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(0, 0, 20, 20) type:kRMMixedIndicator];
            [[theValue(indicator) shouldNot] beNil];
        });

        it(@"loadIndicato kRMMixedIndicatorr", ^{
            indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(0, 0, 20, 20) type:kRMMixedIndicator];
            [indicator loadIndicator];
            [[theValue(indicator) shouldNot] beNil];
        });

        it(@"loadIndicator kRMClosedIndicator", ^{
            indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(0, 0, 20, 20) type:kRMClosedIndicator];
            [indicator loadIndicator];
            [[theValue(indicator) shouldNot] beNil];
        });

        it(@"addDisplayLabel", ^{
            [indicator addDisplayLabel];
            [[theValue(indicator) shouldNot] beNil];
        });

        it(@"setIndicatorAnimationDuration", ^{
            [indicator setIndicatorAnimationDuration:10];
            [[theValue(indicator) shouldNot] beNil];
        });

        it(@"pathWithStartAngle", ^{
            UIBezierPath *path = [indicator pathWithStartAngle:0 endAngle:180 radius:20 type:kRMMixedIndicator];
            [[theValue(path) shouldNot] beNil];
        });

        it(@"pathWithStartAngle", ^{
            UIBezierPath *path = [indicator pathWithStartAngle:0 endAngle:180 radius:20 type:kRMClosedIndicator];
            [[theValue(path) shouldNot] beNil];
        });

        it(@"drawRect", ^{
            indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(0, 0, 20, 20) type:kRMClosedIndicator];
            [indicator drawRect:CGRectZero];
            [[theValue(indicator) shouldNot] beNil];
        });
    });
});
SPEC_END
