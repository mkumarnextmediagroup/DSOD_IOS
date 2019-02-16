//
//  CompanyDetailReviewsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/1/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyDetailReviewsViewController.h"
#import "JobDSOModel.h"
#import "CompanyReviewHeaderTableViewCell.h"
#import "CompanyReviewTableViewCell.h"

SPEC_BEGIN(CompanyDetailReviewsViewControllerTests)
describe(@"Unit Test For CompanyDetailReviewsViewController", ^{
    __block CompanyDetailReviewsViewController *controller;

    beforeEach(^{
        controller = [CompanyDetailReviewsViewController new];
    });

    context(@"methods", ^{
        it(@"contentOffsetToPointZero", ^{
            [controller contentOffsetToPointZero];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setJobDSOModel", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"abcdefghijklmnopqrstuvwxyz";
            [controller setJobDSOModel:model];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"reloadComment", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"abcdefghijklmnopqrstuvwxyz";
            controller.jobDSOModel = model;
            [controller reloadComment];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"getNewJobDSOModel", ^{
            JobDSOModel *model = [JobDSOModel new];
            model.id = @"abcdefghijklmnopqrstuvwxyz";
            controller.jobDSOModel = model;
            [controller getNewJobDSOModel];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"seeMore", ^{
            [controller seeMore];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"writeReview", ^{
            [controller writeReview];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildFooterView", ^{
            UIView *view = [controller buildFooterView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:CompanyReviewHeaderTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
            [tableView registerClass:CompanyReviewTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"companyReviewHeaderCell", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:CompanyReviewHeaderTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
            [tableView registerClass:CompanyReviewTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
            UITableViewCell *cell = [controller companyReviewHeaderCell:tableView data:[JobDSOModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"companyReviewTableViewCell", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:CompanyReviewHeaderTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
            [tableView registerClass:CompanyReviewTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
            UITableViewCell *cell = [controller companyReviewTableViewCell:tableView data:[CompanyReviewModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"edgeInsetsMake", ^{
            UIEdgeInsets insets = [controller edgeInsetsMake];
            [[theValue(insets) should] equal:theValue(UIEdgeInsetsMake(0, 0, 0, 0))];
        });
    });
});
SPEC_END
