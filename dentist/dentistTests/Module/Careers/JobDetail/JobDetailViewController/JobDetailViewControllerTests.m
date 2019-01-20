//
//  JobDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/20/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "JobDetailViewController.h"

SPEC_BEGIN(JobDetailViewControllerTests)
describe(@"Unit Test For JobDetailViewController", ^{
    __block JobDetailViewController *controller;

    beforeEach(^{
        controller = [JobDetailViewController new];
        controller.jobId = @"jobID";
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewWillAppear", ^{
            [controller viewWillAppear:YES];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewWillDisappear", ^{
            [controller viewWillDisappear:YES];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildView", ^{
            [controller viewDidLoad];
            [controller buildView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setApplyButtonEnable", ^{
            [controller setApplyButtonEnable:YES];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildHeader", ^{
            [controller buildHeader];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showVideo", ^{
            [controller showVideo:@"<iframe></iframe>"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"closePage", ^{
            [controller closePage];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showLocation", ^{
            [controller showLocation];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"attention", ^{
            [controller attention];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"share", ^{
            [controller share];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"clickOkBtn", ^{
            [controller clickOkBtn];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"uploadResume", ^{
            [controller uploadResume];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"applyNow", ^{
            [controller applyNow];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"applyForJob", ^{
            [controller applyForJob];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onHttpProgress", ^{
            [controller onHttpProgress:2 total:10 percent:20];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"decoderUrlEncodeStr", ^{
            NSString * path = [controller decoderUrlEncodeStr:@"https://www.example.com"];
            [[path should] equal:@"https://www.example.com"];
        });

        it(@"fileName", ^{
            NSString *string = [controller fileName:@"fileName"];
            [[string should] equal:@"fileName"];
        });

        it(@"tableContentView", ^{
            UIView *view = [controller tableContentView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"didDentistSelectItemAtIndex", ^{
            [controller didDentistSelectItemAtIndex:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(50)];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(1)];
        });

        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:indexPath];
            if (IPHONE_X) {
                [[theValue(height) should] equal:theValue(762)];
            }
        });

        it(@"cellForRowAtIndexPath", ^{
            UITableView *tb = [UITableView new];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:tb cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"heightForRowAtIndexPath", ^{
            UITableView *tb = [UITableView new];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:tb didSelectRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
