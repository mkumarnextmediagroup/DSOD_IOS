//
//  EducationCategoryCourseViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/28/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationCategoryCourseViewController.h"

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

//        - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//        - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//        - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//        - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//        - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//        - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
    });
});
SPEC_END
