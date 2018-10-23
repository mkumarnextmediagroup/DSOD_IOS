//
//  LoginTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "TestPage.h"

SPEC_BEGIN(TestPageTests)

describe(@"Unit test for StudentController", ^{
    __block TestPage *controller;

    beforeEach(^{
        controller = [TestPage new];
    });

    context(@"Load UI", ^{
        it(@"Check view not nil", ^{
            [controller viewDidLoad];
            [[controller.view shouldNot] beNil];
        });
    });

});

SPEC_END
