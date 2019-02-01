//
//  CompanyDetailJobsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/1/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyDetailJobsViewController.h"
#import "FindJobsTableViewCell.h"

SPEC_BEGIN(CompanyDetailJobsViewControllerTests)
describe(@"Unit Test For CompanyDetailJobsViewController", ^{
    __block CompanyDetailJobsViewController *controller;

    beforeEach(^{
        controller = [CompanyDetailJobsViewController new];
    });

    context(@"methods", ^{
        it(@"contentOffsetToPointZero", ^{
            [controller contentOffsetToPointZero];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"reloadData", ^{
            [controller reloadData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildView", ^{
            [controller buildView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setCompanyId", ^{
            [controller setCompanyId: @"companyId"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(32)];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"setJobCountTitle", ^{
            [controller setJobCountTitle:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tbv = [UITableView new];
            [tbv registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
            UITableViewCell *cell = [controller tableView:tbv cellForRowAtIndexPath:ip];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:ip];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll: [UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
