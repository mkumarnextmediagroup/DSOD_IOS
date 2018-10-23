//
//  LoginTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/22/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "LoginController.h"
#import "Proto.h"

SPEC_BEGIN(LoginControllerTests)

describe(@"Unit test for Login", ^{
    __block LoginController *controller;

    beforeEach(^{
        controller = [LoginController new];
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
        it(@"Valid Email and password", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"test@email.com"];
            [controller.pwdEdit setText:@"12345678"];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue(controller.loginButton.enabled) should] equal:theValue(YES)];
        });

        it(@"Not Valid Email", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"abcd"];
            [controller textFieldDidEndEditing:controller.emailEdit];
            [[theValue(controller.loginButton.enabled) should] equal:theValue(NO)];
        });

        it(@"Not Valid Password", ^{
            [controller viewDidLoad];
            [controller.pwdEdit setText:@"a"];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue(controller.loginButton.enabled) should] equal:theValue(NO)];
        });

        it(@"Valid Email and password and selected Check Button", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"test@email.com"];
            [controller.pwdEdit setText:@"12345678"];
            [controller.checkButton setSelected:YES];
            [controller textFieldDidEndEditing:controller.pwdEdit];
            [[theValue(controller.loginButton.enabled) should] equal:theValue(YES)];
        });
    });

    context(@"Login Press", ^{
        it(@"Login with Valid Email and Password", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"test@email.com"];
            [controller.pwdEdit setText:@"12345678"];
            [controller clickLogin:controller.loginButton];
            [[[controller.pwdEdit text] shouldNot] equal:@""];
        });

        it(@"Login without password", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"test@email.com"];
            [controller.pwdEdit setText:@""];
            [controller clickLogin:controller.loginButton];
            [[[controller.pwdEdit text] should] equal:@""];
        });

        it(@"Login with hidden check button and without password", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"test@email.com"];
            [controller.pwdEdit setText:@""];
            [controller.checkButton setSelected:YES];
            [controller.checkButton setHidden:YES];
            [controller clickLogin:controller.loginButton];
            [[[controller.pwdEdit text] should] equal:@""];
        });

        it(@"Login with touch id or face id", ^{
            [controller viewDidLoad];
            [controller.emailEdit setText:@"test@email.com"];
            [controller.pwdEdit setText:@""];
            [controller.checkButton setSelected:YES];
            [controller clickLogin:controller.loginButton];
            [[[controller.pwdEdit text] should] equal:@""];
        });
    });
});

SPEC_END
