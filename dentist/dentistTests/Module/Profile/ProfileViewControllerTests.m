//
//  ProfileViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/25/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ProfileViewController.h"

SPEC_BEGIN(ProfileViewControllerTests)

describe(@"Unit test for ProfileViewController", ^{
    __block ProfileViewController *controller;

    beforeEach(^{
        controller = [ProfileViewController new];
    });

    context(@"UnitTest For LifeCycle", ^{
        it(@"View Did Load", ^{
            [controller viewDidLoad];
            [[controller.view shouldNot] beNil];
        });
    });
});


SPEC_END
