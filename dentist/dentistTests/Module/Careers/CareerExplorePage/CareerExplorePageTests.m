
//
//  CareerExplorePageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/13/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerExplorePage.h"

SPEC_BEGIN(CareerExplorePageTests)
describe(@"Unit Test For CareerExplorePage", ^{
    __block CareerExplorePage *page;

    beforeEach(^{
        page = [CareerExplorePage new];
    });

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            [page viewWillAppear:TRUE];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"createFunBtn", ^{
            [page createFunBtn];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"functionBtnClick", ^{
            UIButton *button = [UIButton new];
            button.tag = 10;
            [page functionBtnClick: button];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"functionBtnClick", ^{
            UIButton *button = [UIButton new];
            button.tag = 11;
            [page functionBtnClick: button];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"functionBtnClick", ^{
            UIButton *button = [UIButton new];
            button.tag = 12;
            [page functionBtnClick: button];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"functionBtnClick", ^{
            UIButton *button = [UIButton new];
            button.tag = 13;
            [page functionBtnClick: button];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
