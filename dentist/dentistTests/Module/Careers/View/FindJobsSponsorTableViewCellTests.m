//
//  FindJobsSponsorTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/17/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "FindJobsSponsorTableViewCell.h"

SPEC_BEGIN(FindJobsSponsorTableViewCellTests)
describe(@"Unit Test For FindJobsSponsorTableViewCell", ^{
    __block FindJobsSponsorTableViewCell *cell;

    beforeEach(^{
        cell = [FindJobsSponsorTableViewCell new];
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
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setIsNew", ^{
            [cell setIsNew:NO];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setInfo", ^{
            [cell setInfo:[JobModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"followAction", ^{
            [cell followAction:[UIButton new]];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
