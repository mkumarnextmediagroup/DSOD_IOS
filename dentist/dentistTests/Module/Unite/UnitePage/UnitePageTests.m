//
//  UnitePageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/6/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UnitePage.h"
#import "MagazineModel.h"

SPEC_BEGIN(UnitePageTests)
describe(@"Unit Test For UnitePage", ^{
    __block UnitePage *page;

    beforeEach(^{
        page = [[UnitePage alloc] init];
    });

    context(@"methods", ^{
        it(@"addNotification", ^{
            [page addNotification];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"setupNavigation", ^{
            [page setupNavigation];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"enterTeamCard", ^{
            [page enterTeamCard:[MagazineModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"enterUniteDownloading", ^{
            [page enterUniteDownloading:[MagazineModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"setupRefresh", ^{
            [page setupRefresh];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"showTopIndicator", ^{
            [page showTopIndicator];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"hideTopIndicator", ^{
            [page hideTopIndicator];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"firstRefresh", ^{
            [page firstRefresh];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"getDatas", ^{
            [page getDatas: TRUE];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"reloadData", ^{
            id objects[] = { @"video url" };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            [page reloadData:array isMore: YES];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"gotoThumView", ^{
            [page gotoThumView:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"openMenu", ^{
            [page openMenu];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"showDownloaded", ^{
            [page showDownloaded];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"showAllIssues", ^{
            [page showAllIssues];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [page tableView:NULL numberOfRowsInSection:0];
            NSLog(@"%ld", (long) num);
        });

        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [page tableView:NULL heightForRowAtIndexPath:indexPath];
            [[theValue(height) should] equal:theValue(SCREENWIDTH * 6 /5 + 100)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [page tableView:NULL cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [page tableView:NULL didSelectRowAtIndexPath:indexPath];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"scrollViewDidEndDragging", ^{
            [page scrollViewDidEndDragging:NULL willDecelerate:TRUE];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"thumDidSelectMenu", ^{
            [page thumDidSelectMenu:0];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
