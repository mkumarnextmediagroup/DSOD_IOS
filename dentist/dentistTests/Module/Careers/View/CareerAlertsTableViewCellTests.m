
//
//  CareerAlertsTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/18/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerAlertsTableViewCell.h"

SPEC_BEGIN(CareerAlertsTableViewCellTests)
describe(@"Unit Test For CareerAlertsTableViewCell", ^{
    __block CareerAlertsTableViewCell *cell;

    beforeEach(^{
        cell = [CareerAlertsTableViewCell new];
    });

    context(@"methods", ^{
        it(@"setAlerModel", ^{
            [cell setAlerModel:[JobAlertsModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"edit", ^{
            [cell edit:[UIButton new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"alert", ^{
            [cell alert:[UIButton new]];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
