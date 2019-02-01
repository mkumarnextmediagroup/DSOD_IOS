//
//  CompanyDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/30/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyDetailViewController.h"

SPEC_BEGIN(CompanyDetailViewControllerTests)
describe(@"Unit Test For CompanyDetailViewController", ^{
    __block CompanyDetailViewController *controller;

    beforeEach(^{
        controller = [CompanyDetailViewController new];
        controller.companyId = @"companyID";
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"loadData", ^{
            [controller loadData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"addNavBar", ^{
            [controller addNavBar];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildView", ^{
            [controller buildView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildHeader", ^{
            [controller buildHeader];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showVideo", ^{
            [controller showVideo:@"video"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"searchClick", ^{
            [controller searchClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showLocation", ^{
            [controller showLocation];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setupTableContentVC", ^{
            [controller setupTableContentVC];
            [[theValue(controller.view) shouldNot] beNil];
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
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] heightForRowAtIndexPath:ip];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"cellForRowAtIndexPath", ^{
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"CompanyDetailJobsViewDidSelectAction", ^{
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
