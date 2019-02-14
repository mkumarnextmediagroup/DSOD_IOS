//
//  CareerAddReviewViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/15/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerAddReviewViewController.h"

SPEC_BEGIN(CareerAddReviewViewControllerTests)
describe(@"Unit Test For CareerAddReviewViewController", ^{
    __block CareerAddReviewViewController *controller;

    beforeEach(^{
        controller = [CareerAddReviewViewController new];
    });

    context(@"methods", ^{
        it(@"openBy", ^{
            [CareerAddReviewViewController openBy:[UIViewController new] dsoId:@"dosid" successCallbak:^{
                
            }];
        });

        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"addNavBar", ^{
            [controller addNavBar];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildViews", ^{
            [controller buildViews];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"employeeChange", ^{
            [controller employeeChange:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"selectChanged", ^{
            [controller selectChanged:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"textViewShouldBeginEditing", ^{
            [controller textViewShouldBeginEditing:[UITextView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"textViewDidEndEditing", ^{
            [controller textViewDidEndEditing:[UITextView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"textView", ^{
            [controller textView:[UITextView new] shouldChangeTextInRange:NSMakeRange(0, 0) replacementText:@"text"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"shouldChangeTextInRange", ^{
            NSString *text = [controller text:[UITextView new]];
            [[text should] equal:@""];
        });
    });
});
SPEC_END
