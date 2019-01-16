//
//  DSOProfilePageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/13/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DSOProfilePage.h"
#import "DSOProfileTableViewCell.h"

SPEC_BEGIN(DSOProfilePageTests)
describe(@"Unit Test For DSOProfilePage", ^{
    __block DSOProfilePage *page;

    beforeEach(^{
        page = [DSOProfilePage new];
    });

    context(@"methods", ^{
        it(@"backToFirst", ^{
            [page backToFirst];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"searchClick", ^{
            [page searchClick];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [page tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should]equal:theValue(0)];
        });

        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [page  tableView:[UITableView new] heightForRowAtIndexPath:ip];
            [[theValue(height) should] equal:theValue(80)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[DSOProfileTableViewCell class] forCellReuseIdentifier:@"cell"];
            UITableViewCell *cell = [page tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [page tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [page onBack:[UIButton new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [page scrollViewDidScroll:[UIScrollView new]];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
