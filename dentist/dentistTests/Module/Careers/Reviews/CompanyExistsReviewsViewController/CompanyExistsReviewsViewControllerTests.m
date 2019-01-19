//
//  CompanyExistsReviewsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/15/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyExistsReviewsViewController.h"
#import "CompanyExistsReviewsTableViewCell.h"

SPEC_BEGIN(CompanyExistsReviewsViewControllerTests)
describe(@"Unit Test For CompanyExistsReviewsViewController", ^{
    __block CompanyExistsReviewsViewController *controller;

    beforeEach(^{
        controller = [CompanyExistsReviewsViewController new];
    });

    context(@"methods", ^{
        it(@"openBy", ^{
            [CompanyExistsReviewsViewController openBy:[UIViewController new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"addNavBar", ^{
            [controller addNavBar];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"backToFirst", ^{
            [controller backToFirst];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"searchClick", ^{
            [controller searchClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildView", ^{
            [controller buildView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setupRefresh", ^{
            [controller setupRefresh];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showTopIndicator", ^{
            [controller showTopIndicator];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"hideTopIndicator", ^{
            [controller hideTopIndicator];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"firstRefresh", ^{
            [controller firstRefresh];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"getDatas", ^{
            [controller getDatas: YES];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"reloadData", ^{
            [controller reloadData:NULL isMore:NO];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[CompanyExistsReviewsTableViewCell class] forCellReuseIdentifier:@"CompanyExistsReviewsTableViewCell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"scrollViewDidEndDragging", ^{
            [controller scrollViewDidEndDragging:NULL willDecelerate:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
