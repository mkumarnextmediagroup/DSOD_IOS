//
//  CmsSearchPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/4/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsSearchPage.h"

SPEC_BEGIN(CmsSearchPageTests)
describe(@"Unit Test For CmsSearchPage", ^{
    __block CmsSearchPage *page;

    beforeEach(^{
        page = [CmsSearchPage new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            page.isRefresh = NO;
            [page viewWillAppear:TRUE];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"viewDidLoad", ^{
            [page viewDidLoad];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
        });

        it(@"refreshData", ^{
            [page refreshData];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"refreshData", ^{
            page.items = @[@"1", @"2", @"2"];
            [page refreshData];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
        });
    });
});
SPEC_END
