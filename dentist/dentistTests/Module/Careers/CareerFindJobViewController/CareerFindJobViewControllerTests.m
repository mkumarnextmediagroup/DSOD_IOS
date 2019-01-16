//
//  CareerFindJobViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/13/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerFindJobViewController.h"
#import "FindJobsTableViewCell.h"
#import "JobModel.h"

SPEC_BEGIN(CareerFindJobViewControllerTests)
describe(@"Unit Test For CareerFindJobViewController", ^{
    __block CareerFindJobViewController *controller;

    beforeEach(^{
        controller = [CareerFindJobViewController new];
    });

    context(@"methods", ^{
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

        it(@"makeHeaderView", ^{
            UIView *view = [controller makeHeaderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:@"FindJobsTableViewCell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            JobModel *model = [JobModel new];
            model.id = @"1";
            id objects[] = { model };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSMutableArray *array = [NSMutableArray arrayWithObjects:objects
                                                 count:count];
            controller.infoArr = array;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
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

        it(@"searchCondition", ^{
            [controller searchCondition: @{}];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
