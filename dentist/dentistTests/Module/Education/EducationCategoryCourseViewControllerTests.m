//
//  EducationCategoryCourseViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/28/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationCategoryCourseViewController.h"
#import "CourseTableViewCell.h"

SPEC_BEGIN(EducationCategoryCourseViewControllerTests)
describe(@"Unit Test For EducationCategoryCourseViewController", ^{
    __block EducationCategoryCourseViewController *controller;

    beforeEach(^{
        controller = [EducationCategoryCourseViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"searchClick", ^{
            [controller searchClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"back", ^{
            [controller back];
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

        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [controller numberOfSectionsInTableView:[UITableView new]];
            [[theValue(num) should] equal: theValue(1)];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat h = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(h) should] equal: theValue(15)];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            UITableView *tb = [UITableView new];
            [tb registerClass:[CourseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CourseTableViewCell class])];
            UITableViewCell *cell = [controller tableView:tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
