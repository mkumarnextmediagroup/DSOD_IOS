//
//  CareerMyJobViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/13/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerMyJobViewController.h"
#import "FindJobsSponsorTableViewCell.h"

SPEC_BEGIN(CareerMyJobViewControllerTests)
describe(@"Unit Test For CareerMyJobViewController", ^{
    __block CareerMyJobViewController *controller;

    beforeEach(^{
        controller = [CareerMyJobViewController new];
    });

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            [controller viewWillAppear:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewWillAppear with index 1", ^{
            controller.selectIndex = 1;
            [controller viewWillAppear:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"createEmptyNotice", ^{
            [controller createEmptyNotice];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"backToFirst", ^{
            [controller backToFirst];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"refreshData", ^{
            [controller refreshData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"refreshData with index 1", ^{
            controller.selectIndex = 1;
            [controller refreshData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setupRefresh", ^{
            [controller setupRefresh];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"refreshClick", ^{
            [controller refreshClick:[UIRefreshControl new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"searchClick", ^{
            [controller searchClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"clickFilter", ^{
            [controller clickFilter:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setJobCountTitle", ^{
            [controller setJobCountTitle:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setJobCountTitle with count = 1", ^{
            [controller setJobCountTitle:1];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"makeHeaderView", ^{
            UIView *header = [controller makeHeaderView];
            [[theValue(header) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"numberOfRowsInSection with index = 1", ^{
            controller.selectIndex = 1;
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:@"myjobcell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"didDentistSelectItemAtIndex", ^{
            [controller didDentistSelectItemAtIndex:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"FollowJobAction", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller FollowJobAction:indexPath view:[UIView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"UnFollowJobAction", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller UnFollowJobAction:indexPath view:[UIView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
