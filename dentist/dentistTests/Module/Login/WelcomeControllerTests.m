//
//  LoginTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "WelcomController.h"

SPEC_BEGIN(WelcomeControllerTests)

describe(@"Unit test for Welcome Controller", ^{
    __block WelcomController *controller;

    beforeEach(^{
        controller = [WelcomController new];
    });

    context(@"Load UI", ^{
        it(@"Check view not nil", ^{
            [controller viewDidLoad];
            [[controller.view shouldNot] beNil];
        });
    });

});

SPEC_END
