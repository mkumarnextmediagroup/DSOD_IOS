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
            [controller setJobDSOModel:[JobDSOModel new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"reloadComment", ^{
            [controller reloadComment];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"getNewJobDSOModel", ^{
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
        });

        it(@"", ^{

        });

        it(@"", ^{

        });

        it(@"", ^{

        });
//        - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//        - (UITableViewCell*)companyReviewHeaderCell:tableView data:(JobDSOModel*)model;
//        - (UITableViewCell*)companyReviewTableViewCell:tableView data:(CompanyReviewModel*)model;
//        - (UIEdgeInsets)edgeInsetsMake;
    });
});
SPEC_END
