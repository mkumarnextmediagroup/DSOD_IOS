//
//  CompanyReviewsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/16/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyReviewsViewController.h"
#import "JobDSOModel.h"
#import "CompanyReviewsCell.h"

SPEC_BEGIN(CompanyReviewsViewControllerTests)
describe(@"Unit Test For CompanyReviewsViewController", ^{
    __block CompanyReviewsViewController *controller;

    beforeEach(^{
        controller = [CompanyReviewsViewController new];
        [[UINavigationController alloc] initWithRootViewController:controller];
    });

    context(@"methods", ^{

        it(@"viewDidLoad", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"dismiss", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller dismiss];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"hideTopIndicator", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller hideTopIndicator];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"reloadData", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller reloadData:nil isMore:false];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"writeReview", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller writeReview];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"resetSortAndFilter", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller resetSortAndFilter];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"sortOnClick", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller sortOnClick:[UIView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"filterOnClick", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller filterOnClick:[UIView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(40)];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[CompanyReviewsCell class] forCellReuseIdentifier:@"CompanyReviewsCell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"scrollViewDidEndDragging", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"id";
            controller.jobDSOModel = model;
            [controller viewDidLoad];
            [controller scrollViewDidEndDragging:[UIScrollView new] willDecelerate:false];
            [[theValue(controller.view) shouldNot] beNil];
        });

    });
});
SPEC_END
