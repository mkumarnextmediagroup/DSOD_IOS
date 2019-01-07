//
//  UnitePageCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UnitePageCell.h"
#import "MagazineModel.h"

SPEC_BEGIN(UnitePageCellTests)
describe(@"Unit Test For UnitePageCell", ^{
    __block UnitePageCell *cell;

    beforeEach(^{
        cell = [UnitePageCell new];
    });

    context(@"methods", ^{
        it(@"initWithStyle", ^{
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"setMagazineModel", ^{
            [cell setMagazineModel:[MagazineModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"optionBtnDownloadStyle", ^{
            [cell optionBtnDownloadStyle];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"optionBtnDownloadingStyle", ^{
            [cell optionBtnDownloadingStyle];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"optionBtnReadStyle", ^{
            [cell optionBtnReadStyle];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"optionBtnAction", ^{
            [cell optionBtnAction: [UIButton new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"getUnitePageDownloadStatus", ^{
            UnitePageDownloadStatus status = [cell getUnitePageDownloadStatus];
            [[theValue(status) should] equal:theValue(UPageNoDownload)];
        });
    });
});
SPEC_END
