//
//  CareerAlertsAddViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/8/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerAlertsAddViewController.h"
#import "JobAlertsModel.h"
#import "TextFieldImageView.h"

SPEC_BEGIN(CareerAlertsAddViewControllerTests)
describe(@"Unit Test For CareerAlertsAddViewController", ^{
    __block CareerAlertsAddViewController *controller;

    beforeEach(^{
        controller = [CareerAlertsAddViewController new];
    });

    context(@"methods", ^{
        it(@"setModel", ^{
            JobAlertsModel *model = [JobAlertsModel new];
            [controller setModel:model];
            [[theValue(controller.model) should] equal:theValue(model)];
        });

        it(@"onTap", ^{
            [controller onTap:controller.view];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onback", ^{
            [controller onback];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"makeFooterView", ^{
            UIView *view = [controller makeFooterView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"heightForRowAtIndexPath", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(height) should] equal:theValue(82)];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(4)];
        });

        it(@"cellForRowAtIndexPath", ^{
            UITableViewCell *cell = [controller tableView:[UITableView new] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"clickSave", ^{
            [controller clickSave:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"getCurrentLocation", ^{
            [controller getCurrentLocation];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"textFieldShouldBeginEditing", ^{
            UITextField *tf = [UITextField new];
            tf.tag = 0;
            BOOL shouldBegin = [controller textFieldShouldBeginEditing:tf];
            [[theValue(shouldBegin) should] equal:theValue(YES)];
        });

        it(@"textFieldShouldBeginEditing", ^{
            UITextField *tf = [UITextField new];
            tf.tag = 1;
            BOOL shouldBegin = [controller textFieldShouldBeginEditing:tf];
            [[theValue(shouldBegin) should] equal:theValue(YES)];
        });

        it(@"textFieldShouldBeginEditing", ^{
            UITextField *tf = [UITextField new];
            tf.tag = 2;
            BOOL shouldBegin = [controller textFieldShouldBeginEditing:tf];
            [[theValue(shouldBegin) should] equal:theValue(NO)];
        });

        it(@"textFieldShouldBeginEditing", ^{
            UITextField *tf = [UITextField new];
            tf.tag = 3;
            BOOL shouldBegin = [controller textFieldShouldBeginEditing:tf];
            [[theValue(shouldBegin) should] equal:theValue(NO)];
        });

        it(@"textFieldShouldBeginEditing", ^{
            UITextField *tf = [UITextField new];
            BOOL shouldBegin = [controller textFieldShouldBeginEditing:tf];
            [[theValue(shouldBegin) should] equal:theValue(YES)];
        });
    });
});
SPEC_END
