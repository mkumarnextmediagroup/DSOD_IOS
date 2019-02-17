//
//  DSOProfileTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/16/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DSOProfileTableViewCell.h"
#import "JobDSOModel.h"

SPEC_BEGIN(DSOProfileTableViewCellTests)
describe(@"Unit Test For DSOProfileTableViewCell", ^{
    __block DSOProfileTableViewCell *cell;

    beforeEach(^{
        cell = [DSOProfileTableViewCell new];
    });

    context(@"methods", ^{
        it(@"bindInfo", ^{
            [cell bindInfo:[JobDSOModel new]];
        });
    });
});
SPEC_END
