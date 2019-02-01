//
//  JobDetailDescriptionViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/21/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "JobDetailDescriptionViewController.h"

SPEC_BEGIN(JobDetailDescriptionViewControllerTests)
describe(@"Unit Test For JobDetailDescriptionViewController", ^{
    __block JobDetailDescriptionViewController *controller;

    beforeEach(^{
        controller = [JobDetailDescriptionViewController new];
    });

    context(@"methods", ^{
//        - (UIEdgeInsets)edgeInsetsMake;
        it(@"edgeInsetsMake", ^{
            UIEdgeInsets insets = [controller edgeInsetsMake];
            [[theValue(insets) should] equal:theValue(UIEdgeInsetsMake(0, 0, 80, 0))];
        });
    });
});
SPEC_END
