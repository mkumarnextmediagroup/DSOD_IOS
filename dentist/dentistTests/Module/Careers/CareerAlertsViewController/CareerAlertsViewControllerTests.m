//
//  CareerAlertsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/13/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerAlertsViewController.h"
#import "JobAlertsModel.h"
#import "CareerAlertsTableViewCell.h"

SPEC_BEGIN(CareerAlertsViewControllerTests)
describe(@"Unit Test For CareerAlertsViewController", ^{
    __block CareerAlertsViewController *controller;

    beforeEach(^{
        controller = [CareerAlertsViewController new];
    });

    context(@"methods", ^{
        it(@"setNavigationItem", ^{
            [controller setNavigationItem];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"addClick", ^{
            [controller addClick];
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

        it(@"createEmptyNotice", ^{
            [controller createEmptyNotice];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:ip];
            [[theValue(height) should]equal:theValue(77)];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should]equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[CareerAlertsTableViewCell class] forCellReuseIdentifier:@"CareerAlertsTableViewCell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"canEditRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            BOOL canEdit = [controller tableView:[UITableView new] canEditRowAtIndexPath:indexPath];
            [[theValue(YES) should] equal:theValue(canEdit)];
        });

        it(@"titleForDeleteConfirmationButtonForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            NSString *title = [controller tableView:[UITableView new] titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
            [[title should] equal:@"          "];
        });

        it(@"willBeginEditingRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] willBeginEditingRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"didEndEditingRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didEndEditingRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"commitEditingStyle", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] commitEditingStyle:UITableViewCellEditingStyleNone forRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"configSwipeButtons", ^{
            [controller configSwipeButtons];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"configDeleteButton", ^{
            [controller configDeleteButton:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"deleteAction", ^{
            [controller deleteAction:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"JobAlertsEditAction", ^{
            [controller JobAlertsEditAction:[JobAlertsModel new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"JobAlertsAction", ^{
            JobAlertsModel *model = [JobAlertsModel new];
            model.status = YES;
            [controller JobAlertsAction:model];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
