//
//  JobsOfDSODetailTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/17/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "JobsOfDSODetailTableViewCell.h"
#import "FindJobsTableViewCell.h"

SPEC_BEGIN(JobsOfDSODetailTableViewCellTests)
describe(@"Unit Test For JobsOfDSODetailTableViewCell", ^{
    __block JobsOfDSODetailTableViewCell *cell;

    beforeEach(^{
        cell = [JobsOfDSODetailTableViewCell new];
    });

    context(@"methods", ^{
        it(@"buildTable", ^{
            [cell buildTable];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setTotalCount", ^{
            [cell setTotalCount:0];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setTotalCount", ^{
            [cell setTotalCount:1];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setInfoArr", ^{
            JobModel *model = [JobModel new];
            model.id = @"1";
            id objects[] = { model };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSMutableArray *array = [NSMutableArray arrayWithObjects:objects
                                                               count:count];
            [cell setInfoArr:array];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"makeHeaderView", ^{
            UIView *view = [cell makeHeaderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            JobModel *model = [JobModel new];
            model.id = @"1";
            id objects[] = { model };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSMutableArray *array = [NSMutableArray arrayWithObjects:objects
                                                               count:count];
            [cell setInfoArr:array];
            NSInteger num = [cell tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should]equal:theValue(1)];
        });

        it(@"cellForRowAtIndexPath", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:FindJobsTableViewCell.class forCellReuseIdentifier:NSStringFromClass(FindJobsTableViewCell.class)];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *_cell = [cell tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(_cell) shouldNot] beNil];
        });
    });
});
SPEC_END
