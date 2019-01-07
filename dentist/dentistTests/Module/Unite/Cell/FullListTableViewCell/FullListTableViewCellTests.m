//
//  FullListTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "FullListTableViewCell.h"
#import "DetailModel.h"

SPEC_BEGIN(FullListTableViewCellTests)
describe(@"Unit Test For FullListTableViewCell", ^{
    __block FullListTableViewCell *cell;

    beforeEach(^{
        cell = [FullListTableViewCell new];
    });

    context(@"methods", ^{
        it(@"bindInfo", ^{
            [cell bindInfo:[DetailModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"initWithStyle", ^{
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"buildViews", ^{
            [cell buildViews];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
