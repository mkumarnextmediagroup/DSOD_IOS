//
//  LoginTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "StudentController.h"

SPEC_BEGIN(StudentControllerTests)

describe(@"Unit test for StudentController", ^{
    __block StudentController *controller;

    beforeEach(^{
        controller = [StudentController new];
    });

    context(@"Load UI", ^{
        it(@"Check view not nil", ^{
            [controller viewDidLoad];
            [[controller.view shouldNot] beNil];
        });
    });

});

SPEC_END
