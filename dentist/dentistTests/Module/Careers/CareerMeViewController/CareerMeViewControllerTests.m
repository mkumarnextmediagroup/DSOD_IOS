//
//  CareerMeViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/9/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerMeViewController.h"

SPEC_BEGIN(CareerMeViewControllerTests)
describe(@"Unit Test For CareerMeViewController", ^{
    __block CareerMeViewController *controller;

    beforeEach(^{
        controller = [CareerMeViewController new];
    });

    context(@"methods", ^{
        it(@"reloadMeData with Image", ^{
            [controller reloadMeData:[UIImage new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"reloadMeData", ^{
            [controller reloadMeData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [controller onBack];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"back", ^{
            [controller back];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"editPortrait", ^{
            [controller editPortrait:controller];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"callActionSheetFunc", ^{
            [controller callActionSheetFunc];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"makeHeaderView", ^{
            UIView *view = [controller makeHeaderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(2)];
        });

        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:indexPath];
            [[theValue(height) should] equal:theValue(60)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:[UITableView new] cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"previewResume", ^{
            [controller previewResume];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"clickTheBtnWithSourceType", ^{
            [controller clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"imagePickerController", ^{
            [controller imagePickerController:[UIImagePickerController new] didFinishPickingMediaWithInfo:@{}];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"afterSelectDo", ^{
            [controller afterSelectDo:[UIImage new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"getDocumentImage", ^{
            NSString *str = [controller getDocumentImage];
            [[str shouldNot] beNil];
        });

        it(@"saveImageDocuments", ^{
            [controller saveImageDocuments:[UIImage new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"uploadHeaderImage", ^{
            [controller uploadHeaderImage:@"header-image"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"saveUserHeader", ^{
            [controller saveUserHeader];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
