//
//  SliderListViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "SliderListView.h"

SPEC_BEGIN(SliderListViewTests)
describe(@"Unit Test For SliderListView", ^{
    __block SliderListView *view;

    beforeEach(^{
        view = [SliderListView new];
    });

    context(@"methods", ^{
        it(@"initSliderView", ^{
            view = [SliderListView initSliderView:TRUE magazineId:@"id"];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"hideSliderView", ^{
            [SliderListView hideSliderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"showSliderView", ^{
            [view showSliderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"sigleTappedPickerView", ^{
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NULL];
            [view sigleTappedPickerView:tapGesture];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initSliderView", ^{
            [view initSliderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"sortGroupByArr", ^{
            [view sortGroupByArr];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"createSearchBar", ^{
            [view createSearchBar];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"createTableview", ^{
            [view createTableview];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"headerView", ^{
            UIView *header = [view headerView];
            [[theValue(header) shouldNot] beNil];
        });

        it(@"showFullList", ^{
            [view showFullList];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"createEmptyNotice", ^{
            [view createEmptyNotice];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"subHeaderView", ^{
            UIView *header = [view subHeaderView];
            [[theValue(header) shouldNot] beNil];
        });

        it(@"searchBarSearchButtonClicked", ^{
            [view searchBarSearchButtonClicked:[UISearchBar new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat height = [view tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(35)];
        });

        it(@"heightForFooterInSection", ^{
            CGFloat height = [view tableView:[UITableView new] heightForFooterInSection:0];
            [[theValue(height) should] equal:theValue(.1)];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *header = [view tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(header) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [view tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) shouldNot] beNil];
        });

        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [view numberOfSectionsInTableView:[UITableView new]];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [view tableView:[UITableView new] cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [view tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"scrollViewWillBeginDecelerating", ^{
            [view scrollViewWillBeginDecelerating:[UIScrollView new]];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
