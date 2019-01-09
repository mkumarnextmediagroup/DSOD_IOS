//
//  DSOProfileSearchPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DSOProfileSearchPage.h"

SPEC_BEGIN(DSOProfileSearchPageTests)
describe(@"Unit Test For DSOProfileSearchPage", ^{
    __block DSOProfileSearchPage *page;

    beforeEach(^{
        page = [DSOProfileSearchPage new];
    });

    context(@"methods", ^{
        it(@"searchBtnClick", ^{
            [page searchBtnClick];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [page onBack:[UIButton new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"createTableviewAndSearchField", ^{
            UINavigationItem *item = [page navigationItem];
            [page createTableviewAndSearchField:item];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"createEmptyNotice", ^{
            [page createEmptyNotice];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"textFieldShouldReturn", ^{
            BOOL shouldReturn = [page textFieldShouldReturn:[UITextField new]];
            [[theValue(shouldReturn) should] equal:theValue(YES)];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [page tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) shouldNot] beNil];
        });


        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [page tableView:[UITableView new] cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [page tableView:[UITableView new] heightForRowAtIndexPath:indexPath];
            [[theValue(height) shouldNot] beNil];
        });
    });
});
SPEC_END
