//
//  CareerMoreViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/9/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerMoreViewController.h"

SPEC_BEGIN(CareerMoreViewControllerTests)
describe(@"Unit Test For CareerMoreViewController", ^{
    __block CareerMoreViewController *controller;

    beforeEach(^{
        controller = [CareerMoreViewController new];
    });

    context(@"methods", ^{
        it(@"sigleTappedPickerView", ^{
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NULL];
            [controller sigleTappedPickerView:tapGesture];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showFuntionBtn", ^{
            [controller showFuntionBtn];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"btnClick", ^{
            [controller btnClick:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
