//
//  UniteArticleTableViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UniteArticleTableViewCell.h"
#import "DetailModel.h"

SPEC_BEGIN(UniteArticleTableViewCellTests)
describe(@"Unit Test For UniteArticleTableViewCell", ^{
    __block UniteArticleTableViewCell *cell;

    beforeEach(^{
        cell = [UniteArticleTableViewCell new];
    });

    context(@"methods", ^{
        it(@"initWithStyle", ^{
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"buildViews", ^{
            [cell buildViews];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"bindInfo", ^{
            cell.isLastInfo = YES;
            [cell bindInfo:[DetailModel new]];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
