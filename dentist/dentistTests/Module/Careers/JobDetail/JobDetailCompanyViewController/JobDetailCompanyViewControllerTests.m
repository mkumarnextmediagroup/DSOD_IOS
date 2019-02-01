//
//  JobDetailCompanyViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/21/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "JobDetailCompanyViewController.h"
#import "JobDSOModel.h"

SPEC_BEGIN(JobDetailCompanyViewControllerTests)
describe(@"Unit Test For JobDetailCompanyViewController", ^{
    __block JobDetailCompanyViewController *controller;

    beforeEach(^{
        controller = [JobDetailCompanyViewController new];
    });

    context(@"methods", ^{
        it(@"contentOffsetToPointZero", ^{
            [controller contentOffsetToPointZero];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setData", ^{
            [controller setData:[JobDSOModel new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"webViewDidFinishLoad", ^{
            [controller webViewDidFinishLoad: [UIWebView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
