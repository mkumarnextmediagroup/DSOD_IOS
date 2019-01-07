//
//  SliderListViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/6/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "SliderListViewController.h"

SPEC_BEGIN(SliderListViewControllerTests)
describe(@"Unit Test For SliderListViewController", ^{
    __block SliderListViewController *controller;

    beforeEach(^{
        controller = [SliderListViewController new];
    });

    context(@"methods", ^{
        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:indexPath];
            [[theValue(height) should] equal: theValue(80)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:[UITableView new] cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal: theValue(125)];
        });

        it(@"heightForHeaderInSection", ^{
            controller.isSearch = TRUE;
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal: theValue(42)];
        });

        it(@"searchBarSearchButtonClicked", ^{
            [controller searchBarSearchButtonClicked:[UISearchBar new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"headerView", ^{
            UIView *view = [controller headerView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"makeNavView", ^{
            UIView *view = [controller makeNavView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"createTableview", ^{
            [controller createTableview];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"createSearchBar", ^{
            [controller createSearchBar];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
