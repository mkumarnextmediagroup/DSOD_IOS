//
//  DiscussTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/28/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DiscussTableViewCell.h"
#import "DiscussInfo.h"

SPEC_BEGIN(DiscussTableViewCellTests)
describe(@"Unit Test For DiscussTableViewCell", ^{
    __block DiscussTableViewCell *cell;

    beforeEach(^{
        cell = [DiscussTableViewCell new];
    });

    context(@"methods", ^{
        it(@"initWithStyle", ^{
            cell = [[DiscussTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setDisInfo", ^{
            DiscussInfo *info = [DiscussInfo new];
            info.disImg = @"link url";
            [cell setDisInfo:info];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
