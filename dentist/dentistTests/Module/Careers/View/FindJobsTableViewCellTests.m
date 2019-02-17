//
//  FindJobsTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/16/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "FindJobsTableViewCell.h"

SPEC_BEGIN(FindJobsTableViewCellTests)
describe(@"Unit Test For FindJobsTableViewCell", ^{
    __block FindJobsTableViewCell *cell;

    beforeEach(^{
        cell = [FindJobsTableViewCell new];
    });

    context(@"methods", ^{
        it(@"updateFollowStatus", ^{
            [cell updateFollowStatus:YES];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"updateFollowStatus", ^{
            [cell updateFollowStatus:NO];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setIsNew", ^{
            [cell setIsNew:YES];
            [[theValue(cell.isNew) should]equal:theValue(YES)];
        });

        it(@"setIsNew", ^{
            [cell setIsNew:NO];
            [[theValue(cell.isNew) should]equal:theValue(NO)];
        });

        it(@"setInfo", ^{
            JobModel *info = [JobModel new];
            [cell setInfo:info];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setInfoDic", ^{
            NSDictionary *info = @{};
            [cell setInfoDic:info];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"followAction", ^{
            [cell followAction:[UIButton new]];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
