//
//  CompanyReviewsDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/17/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyReviewsDetailViewController.h"

SPEC_BEGIN(CompanyReviewsDetailViewControllerTests)
describe(@"Unit Test For CompanyReviewsDetailViewController", ^{
    __block CompanyReviewsDetailViewController *controller;

    beforeEach(^{
        controller = [CompanyReviewsDetailViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"addNavBar", ^{
            [controller addNavBar];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildViews", ^{
            [controller buildViews];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"loadData", ^{
            [controller loadData];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
