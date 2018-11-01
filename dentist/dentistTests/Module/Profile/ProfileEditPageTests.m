//
//  ProfileEditPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/31/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ProfileEditPage.h"
#import "Proto.h"

SPEC_BEGIN(ProfileEditPageTests)

describe(@"Unit test for ProfileViewController", ^{
    __block ProfileEditPage *controller;

    beforeAll(^{
        putServerDomain(0);
        [Proto login:@"hovansu8@gmail.com" pwd:@"A12345678"];
    });

    beforeEach(^{
        controller = [ProfileEditPage new];
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
    });

    context(@"Unit Test TextFieldDidEditing", ^{
        it(@"TextField Did Editing With 4 characters PhoneView ", ^{
            [controller viewDidLoad];
            [controller.phoneView.edit setText:@"1234"];
            [controller textFieldDidEditing:controller.phoneView.edit];
            [[controller.phoneView.edit.text should] equal:@"123-4"];
            [[theValue(controller.num) should] equal:theValue(5)];
        });

        it(@"TextField Did Editing With 8 characters PhoneView ", ^{
            [controller viewDidLoad];
            [controller.phoneView.edit setText:@"12345678"];
            [controller textFieldDidEditing:controller.phoneView.edit];
            [[controller.phoneView.edit.text should] equal:@"1234567-8"];
            [[theValue(controller.num) should] equal:theValue(9)];
        });

        it(@"TextField Did Editing With morethan 12 characters PhoneView ", ^{
            [controller viewDidLoad];
            [controller.phoneView.edit setText:@"1234567891234"];
            [controller textFieldDidEditing:controller.phoneView.edit];
            [[controller.phoneView.edit.text should] equal:@"123456789123"];
            [[theValue(controller.num) should] equal:theValue(12)];
        });

        it(@"TextField Did Editing With length of PhoneView (4) less than num value", ^{
            [controller viewDidLoad];
            controller.num = 10;
            [controller.phoneView.edit setText:@"1234"];
            [controller textFieldDidEditing:controller.phoneView.edit];
            [[controller.phoneView.edit.text should] equal:@"123"];
            [[theValue(controller.num) should] equal:theValue(3)];
        });

        it(@"TextField Did Editing With length of PhoneView (8) less than num value", ^{
            [controller viewDidLoad];
            controller.num = 10;
            [controller.phoneView.edit setText:@"12345678"];
            [controller textFieldDidEditing:controller.phoneView.edit];
            [[controller.phoneView.edit.text should] equal:@"1234567"];
            [[theValue(controller.num) should] equal:theValue(7)];
        });
    });

    context(@"Unit Test textFieldDidEndEditing", ^{
        it(@"Value Of Textfields", ^{
            [controller viewDidLoad];
            [controller.phoneView.edit setText:@"12345678"];
            [controller textFieldDidEndEditing:[UITextField new]];
            [[controller.userInfo.phone should] equal:controller.phoneView.edit.textReplace];
        });
    });

    context(@"Unit Test Click Action", ^{
        it(@"Click Spec", ^{
            [controller viewDidLoad];
            [controller clickSpec:NULL];
        });

        it(@"Click Add Exp", ^{
            [controller viewDidLoad];
            [controller clickAddExp:NULL];
        });

        it(@"Click Exp", ^{
            [controller viewDidLoad];
            [controller clickExp:NULL];
        });
    });

    context(@"Unit Test Select Text", ^{
        it(@"Value Of Textfields", ^{
            [controller viewDidLoad];
            [controller selectText:@"" value:@"" array:[NSArray new] result:^(NSString *str) {}];
        });
    });

    context(@"Unit Test Add Value", ^{
        it(@"add exp", ^{
            [controller viewDidLoad];
            Experience *e = [Experience new];
            [controller addExp:e];
        });
    });
});


SPEC_END
