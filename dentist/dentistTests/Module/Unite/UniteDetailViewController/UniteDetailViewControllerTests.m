//
//  UniteDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/6/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UniteDetailViewController.h"

SPEC_BEGIN(UniteDetailViewControllerTests)
describe(@"Unit Test For UniteDetailViewController", ^{
    __block UniteDetailViewController *controller;

    beforeEach(^{
        controller = [UniteDetailViewController new];
    });

    context(@"methods", ^{
        it(@"onBack", ^{
            [controller onBack:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildView", ^{
            [controller buildView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewWillAppear", ^{
            [controller viewWillAppear:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
