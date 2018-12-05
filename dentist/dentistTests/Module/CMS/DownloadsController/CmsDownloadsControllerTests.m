//
//  CmsDownloadsControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/2/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsDownloadsController.h"
#import "CMSModel.h"
#import "DownloadsItemView.h"

SPEC_BEGIN(CmsDownloadsControllerTests)
describe(@"Unit Test For CmsDownloadsControllerTests", ^{
    __block CmsDownloadsController *controller;

    beforeEach(^{
        controller = [CmsDownloadsController new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            [controller viewWillAppear:TRUE];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"downLoadStateChange", ^{
            NSNotification *notification = [[NSNotification alloc] initWithName:@"unit test" object:[CMSModel new] userInfo:NULL];
            [controller downLoadStateChange:notification];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"updateFilterView", ^{
            [controller updateFilterView];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"updateFilterView with navi", ^{
            (void) [[UINavigationController alloc] initWithRootViewController:controller];
            [controller updateFilterView];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"updateFilterView with category", ^{
            controller.categoryId = @"id";
            [controller updateFilterView];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"viewClassOfItem", ^{
            Class cls = [controller viewClassOfItem:NULL];
            [[cls should] equal:DownloadsItemView.class];
        });

        it(@"heightOfItem", ^{
            CGFloat height = [controller heightOfItem:NULL];
            [[theValue(height) should] equal:theValue(controller.rowheight)];
        });

        it(@"onBindItem", ^{
            [controller onBindItem:[CMSModel new] view:[DownloadsItemView new]];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"ArticleMoreActionModel", ^{
            [controller ArticleMoreActionModel:[CMSModel new]];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"onClickItem", ^{
            [controller onClickItem:[CMSModel new]];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"myActionSheet with index 0", ^{
            [controller myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"myActionSheet with index 1", ^{
            [controller myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"handleDeleteCMS", ^{
            [controller handleDeleteCMS:TRUE];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });

        it(@"clickFilter", ^{
            [controller clickFilter:[UIButton new]];
            [[theValue(controller.topOffset) should] equal:theValue(0)];
        });
    });
});
SPEC_END
