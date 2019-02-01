//
//  JobDetailReviewsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/21/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "JobDetailReviewsViewController.h"

SPEC_BEGIN(JobDetailReviewsViewControllerTests)
describe(@"Unit Test For JobDetailReviewsViewController", ^{
    __block JobDetailReviewsViewController *controller;

    beforeEach(^{
        controller = [JobDetailReviewsViewController new];
    });

    context(@"methods", ^{
        it(@"edgeInsetsMake", ^{
            UIEdgeInsets insets = [controller edgeInsetsMake];
            [[theValue(insets) should] equal:theValue(UIEdgeInsetsMake(0, 0, 80, 0))];
        });
    });
});
SPEC_END
