//
//  EducationPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/24/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationPage.h"
#import "CourseTableViewCell.h"

SPEC_BEGIN(EducationPageTests)
describe(@"Unit Test For EducationPage", ^{
    __block EducationPage *page;

    beforeEach(^{
        page = [EducationPage new];
    });
    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [page viewDidLoad];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"makeHeaderView", ^{
            UIView *view = [page makeHeaderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"goCategoryPage", ^{
            [page goCategoryPage];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"goSponsoredCoursePage", ^{
            [page goSponsoredCoursePage: @"id"];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"seemoreAction", ^{
            [page seemoreAction: [UIButton new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"refreshData", ^{
            [page refreshData];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"setupRefresh", ^{
            [page setupRefresh];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"refreshClick", ^{
            [page refreshClick: [UIRefreshControl new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [page numberOfSectionsInTableView:[UITableView new]];
            [[theValue(num) should] equal:theValue(2)];
        });

        it(@"heightForFooterInSection", ^{
            CGFloat h = [page tableView:[UITableView new] heightForFooterInSection:0];
            [[theValue(h) should] equal:theValue(0)];
        });

        it(@"viewForFooterInSection", ^{
            UIView *v = [page tableView:[UITableView new] viewForFooterInSection:0];
            [[theValue(v) shouldNot] beNil];
        });

        it(@"heightForHeaderInSection", ^{
            CGFloat h = [page tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(h) should] equal:theValue(51)];
        });

        it(@"viewForHeaderInSection", ^{
            UIView *v = [page tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(v) shouldNot] beNil];
        });

        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [page tableView:[UITableView new] numberOfRowsInSection: 0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"didSelectRowAtIndexPath", ^{
            [page tableView:[UITableView new] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [page scrollViewDidScroll:[UITableView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"didDentistSelectItemAtIndex", ^{
            [page didDentistSelectItemAtIndex:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"didYCMenuSelectItemAtIndex", ^{
            [page didYCMenuSelectItemAtIndex:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"sponsoredAction", ^{
            [page sponsoredAction:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
