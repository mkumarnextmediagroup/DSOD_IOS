//
//  CmsForYouPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsForYouPage.h"

SPEC_BEGIN(CmsForYouPageTests)
describe(@"Unit Test For CmsForYouPage", ^{
    __block CmsForYouPage *page;

    beforeEach(^{
        page = [CmsForYouPage new];
    });

    context(@"Methods", ^{
        it(@"viewDidLoad", ^{
            [page viewDidLoad];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"makeHeaderView2", ^{
            UIView *headerView = [page makeHeaderView2];
            [[theValue(headerView) shouldNot] beNil];
        });

        it(@"makeSegPanel with segItems", ^{
            page.segItems = [[NSMutableArray alloc] init];
            [page.segItems addObject:@"1"];
            [page.segItems addObject:@"2"];
            UIView *segPanel = [page makeSegPanel];
            [[theValue(segPanel) shouldNot] beNil];
            [[NSStringFromClass([segPanel class]) should] equal: @"UIScrollView"];
        });

        it(@"onSegValueChanged", ^{
            page.segItems = [[NSMutableArray alloc] init];
            [page.segItems addObject:@"1"];
            [page.segItems addObject:@"2"];
            [page onSegValueChanged:NULL];
            NSInteger n = page.segView.selectedSegmentIndex;
            [[page.category should] equal:page.segItems[n]];
        });

        it(@"onClickItem", ^{
            [page onClickItem:NULL];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"showImageBrowser", ^{
            [page showImageBrowser:1];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
