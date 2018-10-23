//
//  LoginTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "RegController.h"

SPEC_BEGIN(RegControllerTests)

describe(@"Unit test for Login", ^{
    __block RegController *controller;

    beforeEach(^{
        controller = [RegController new];
    });

    context(@"Student", ^{
        it(@"Check it is a student", ^{
            controller.student = YES;
            [controller viewDidLoad];
            [[theValue(controller.student) should] equal:theValue(YES)];
        });

        it(@"Check it is not a student", ^{
            controller.student = NO;
            [controller viewDidLoad];
            [[theValue(controller.student) should] equal:theValue(NO)];
        });
    });

    context(@"Auth", ^{
        it(@"Valid name, email and password", ^{
            [controller viewDidLoad];
            [controller.nameEdit setText:@"test"];
            [controller.emailEdit setText:@"test@test.com"];
            [controller.pwdEdit setText:@"test"];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue([controller.regButton isEnabled]) should] equal:theValue(YES)];
        });

        it(@"Invalid name, name is empty", ^{
            [controller viewDidLoad];
            [controller.nameEdit setText:@""];
            [controller.emailEdit setText:@"test@test.com"];
            [controller.pwdEdit setText:@"test"];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue([controller.regButton isEnabled]) should] equal:theValue(NO)];
        });

        it(@"Invalid email, email is empty", ^{
            [controller viewDidLoad];
            [controller.nameEdit setText:@"test"];
            [controller.emailEdit setText:@""];
            [controller.pwdEdit setText:@"test"];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue([controller.regButton isEnabled]) should] equal:theValue(NO)];
        });

        it(@"Invalid email, email have wrong format", ^{
            [controller viewDidLoad];
            [controller.nameEdit setText:@"test"];
            [controller.emailEdit setText:@"test"];
            [controller.pwdEdit setText:@"test"];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue([controller.regButton isEnabled]) should] equal:theValue(NO)];
        });

        it(@"Invalid password, password is empty", ^{
            [controller viewDidLoad];
            [controller.nameEdit setText:@"test"];
            [controller.emailEdit setText:@"test@gmail.com"];
            [controller.pwdEdit setText:@""];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue([controller.regButton isEnabled]) should] equal:theValue(NO)];
        });
    });
});

SPEC_END
