//
//  CompanyDetailDescriptionViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/1/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CompanyDetailDescriptionViewController.h"

SPEC_BEGIN(CompanyDetailDescriptionViewControllerTests)
describe(@"Unit Test For CompanyDetailDescriptionViewController", ^{
    __block CompanyDetailDescriptionViewController *controller;

    beforeEach(^{
        controller = [CompanyDetailDescriptionViewController new];
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

        it(@"edgeInsetsMake", ^{
            UIEdgeInsets insets = [controller edgeInsetsMake];
            [[theValue(insets) should] equal:theValue(UIEdgeInsetsZero)];
        });

        it(@"setData", ^{
            [controller setData:@"data"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showContent", ^{
            [controller showContent: @"<html></html>"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
