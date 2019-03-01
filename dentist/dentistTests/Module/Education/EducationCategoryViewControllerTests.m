//
//  EducationCategoryViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/28/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationCategoryViewController.h"
#import "EducationCategoryTableViewCell.h"

SPEC_BEGIN(EducationCategoryViewControllerTests)
describe(@"Unit Test For EducationCategoryViewController", ^{
    __block EducationCategoryViewController *controller;

    beforeEach(^{
        controller = [EducationCategoryViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"queryCategoryData", ^{
            [controller queryCategoryData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"back", ^{
            [controller back];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"heightForRowAtIndexPath", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(height) should] equal:theValue(76)];
        });

        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [controller numberOfSectionsInTableView:[UITableView new]];
            [[theValue(num) should] equal:theValue(1)];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(15)];
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
            [tb registerClass:[EducationCategoryTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EducationCategoryTableViewCell class])];
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
