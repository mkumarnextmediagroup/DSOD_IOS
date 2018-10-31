//
//  ProfileViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/25/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ProfileViewController.h"
#import "Proto.h"

SPEC_BEGIN(ProfileViewControllerTests)

describe(@"Unit test for ProfileViewController", ^{
    __block ProfileViewController *controller;

    beforeEach(^{
        putServerDomain(0);
        [Proto login:@"hovansu8@gmail.com" pwd:@"A12345678"];
        controller = [ProfileViewController new];
        
    });

    context(@"UnitTest For LifeCycle", ^{
        it(@"View Did Load", ^{
            [controller viewDidLoad];
            [[controller.view shouldNot] beNil];
        });

        it(@"View Will Appear", ^{
            [controller viewWillAppear:NO];
            [[controller.view shouldNot] beNil];
        });

        it(@"View Did Load and Will Appear", ^{
            [controller viewDidLoad];
            [controller viewWillAppear:NO];
            [[controller.view shouldNot] beNil];
        });
    });

    context(@"UnitTest For Build Views", ^{
        it(@"User Info Speciality Not Nil", ^{
            [controller buildViews];
            [[controller.view shouldNot] beNil];
        });
    });
});


SPEC_END
