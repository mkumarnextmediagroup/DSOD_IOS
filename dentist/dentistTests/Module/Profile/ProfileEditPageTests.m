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
        [Proto login:@"unit.test@gmail.com" pwd:@"A12345678"];
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
            [[controller.view shouldNot] beNil];
        });

        it(@"Click Add Exp", ^{
            [controller viewDidLoad];
            [controller clickAddExp:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"Click Exp", ^{
            [controller viewDidLoad];
            [controller clickExp:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"Click Residency", ^{
            [controller viewDidLoad];
            [controller clickResidency:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"callActionSheetFunc", ^{
            [controller viewDidLoad];
            [controller callActionSheetFunc];
            [[controller.view shouldNot] beNil];
        });

        it(@"Click AddResidency", ^{
            [controller viewDidLoad];
            [controller clickAddResidency:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"Click AddEducation", ^{
            [controller viewDidLoad];
            [controller clickAddEducation:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"Click Edu", ^{
            [controller viewDidLoad];
            [controller clickEdu:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"Click PraticeAddress", ^{
            [controller viewDidLoad];
            [controller clickPraticeAddress:NULL];
            [[controller.view shouldNot] beNil];
        });
    });

    context(@"Unit Test Select Text", ^{
        it(@"Value Of Textfields", ^{
            [controller viewDidLoad];
            [controller selectText:@"" value:@"" array:[NSArray new] result:^(NSString *str) {}];
            [[controller.view shouldNot] beNil];
        });
    });

    context(@"Unit Test modify Value", ^{
        it(@"add exp", ^{
            [controller viewDidLoad];
            Experience *e = [Experience new];
            [controller addExp:e];
            [[controller.view shouldNot] beNil];
        });

        it(@"delete exp", ^{
            [controller viewDidLoad];
            Experience *e = [Experience new];
            [controller deleteExp:e];
            [[controller.view shouldNot] beNil];
        });

        it(@"delete residency", ^{
            [controller viewDidLoad];
            Residency *r = [Residency new];
            [controller deleteResidency:r];
            [[controller.view shouldNot] beNil];
        });

        it(@"add residency", ^{
            [controller viewDidLoad];
            Residency *r = [Residency new];
            [controller addResidency:r];
            [[controller.view shouldNot] beNil];
        });

        it(@"delete education", ^{
            [controller viewDidLoad];
            Education *e = [Education new];
            [controller deleteEducation:e];
            [[controller.view shouldNot] beNil];
        });

        it(@"add education", ^{
            [controller viewDidLoad];
            Education *e = [Education new];
            [controller addEducation:e];
            [[controller.view shouldNot] beNil];
        });

        it(@"edit portrait", ^{
            [controller viewDidLoad];
            [controller editPortrait:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"on save", ^{
            [controller viewDidLoad];
            [controller onSave:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"on back", ^{
            [controller viewDidLoad];
            [controller onBack:NULL];
            [[controller.view shouldNot] beNil];
        });
    });

    context(@"Unit Test UIImage", ^{
        it(@"after select do", ^{
            [controller viewDidLoad];
            UIImage *i = [UIImage new];
            [controller afterSelectDo:i];
            [[controller.selectImage should] equal:i];
        });

        it(@"save Image Documents", ^{
            [controller viewDidLoad];
            UIImage *i = [UIImage new];
            [controller saveImageDocuments:i];
            [[controller.view shouldNot] beNil];
        });

        it(@"get Document Image", ^{
            [controller viewDidLoad];
            NSString *path = [controller getDocumentImage];
            [[path shouldNot] beNil];
        });
    });
});

SPEC_END
