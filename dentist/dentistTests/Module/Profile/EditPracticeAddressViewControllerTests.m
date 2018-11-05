//
//  EditPracticeAddressViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/5/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EditPracticeAddressViewController.h"
#import "Address.h"
#import "Proto.h"

SPEC_BEGIN(EditPracticeAddressViewControllerTests)

describe(@"Unit Test for Practice Address View Controller", ^{
    __block EditPracticeAddressViewController *controller;

    beforeEach(^{
        controller = [EditPracticeAddressViewController new];
    });

    context(@"Life Cycle", ^{
        it(@"View Did Load", ^{
            controller.address = nil;
            [controller viewDidLoad];
            [[controller.view shouldNot] beNil];
        });
    });

    context(@"TextField Delegate", ^{
        it(@"textFieldDidEndEditing Without ZipNew", ^{
            controller.zipView = nil;
            [controller textFieldDidEndEditing:controller.zipView.edit];
            [[controller.view shouldNot] beNil];
        });

        it(@"textFieldDidEndEditing With ZipNew", ^{
            [controller viewDidLoad];
            [controller textFieldDidEndEditing:controller.zipView.edit];
            [[controller.view shouldNot] beNil];
        });
    });

    context(@"Practice Address View Controller's methods", ^{
        it(@"queryStateCityByZipCode", ^{
            [controller queryStateCityByZipCode:@"12345"];
            [[controller.view shouldNot] beNil];
        });

        it(@"handleStateCity", ^{
            [controller handleStateCity:[StateCity new]];
            [[controller.view shouldNot] beNil];
        });

        it(@"handleStateCity with city", ^{
            StateCity *sc = [StateCity new];
            sc.city = @"city";
            [controller handleStateCity:sc];
            [[controller.cityView.edit.text should] equal:sc.city];
        });

        it(@"handleStateCity with state", ^{
            StateCity *sc = [StateCity new];
            sc.state = @"state";
            [controller handleStateCity:sc];
            [[controller.stateView.msgLabel.text should] equal:sc.state];
        });

        it(@"click back", ^{
            [controller clickBack:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"click cancel", ^{
            [controller clickCancel:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"click save", ^{
            [controller viewDidLoad];
            [controller.addr2View.edit setText:@""];
            [controller clickSave:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"click save with addr2View text", ^{
            [controller viewDidLoad];
            [controller.addr2View.edit setText:@"addr2"];
            [controller clickSave:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"click save with addr2View text and saveCallback", ^{
            [controller viewDidLoad];
            [controller.addr2View.edit setText:@"addr2"];
            controller.saveCallback = ^(Address *address) {};
            [controller clickSave:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"click state", ^{
            [controller clickState:NULL];
            [[controller.view shouldNot] beNil];
        });

        it(@"handle result", ^{
            [controller handleResult:NULL ls:[Proto listStates]];
            [[controller.view shouldNot] beNil];
        });
    });
});

SPEC_END
