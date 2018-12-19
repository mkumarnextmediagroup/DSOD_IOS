//
//  CmsCategoryPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/11/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsCategoryPage.h"
#import "ArticleGSkItemView.h"
#import "CMSModel.h"

SPEC_BEGIN(CmsCategoryPageTests)
describe(@"Unit Test For CmsCategoryPage", ^{
    __block CmsCategoryPage *page;

    beforeEach(^{
        page = [CmsCategoryPage new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            [page viewWillAppear:TRUE];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"viewClassOfItem", ^{
            Class cls = [page viewClassOfItem:NULL];
            [[theValue(cls) should] equal:theValue(ArticleGSkItemView.class)];
        });

        it(@"heightOfItem", ^{
            CGFloat height = [page heightOfItem:NULL];
            [[theValue(height) should] equal:theValue(UITableViewAutomaticDimension)];
        });

        it(@"onBindItem", ^{
            [page onBindItem:[CMSModel new] view:[ArticleGSkItemView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"refreshData", ^{
            page.type = @"type";
            [page refreshData];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"ArticleMoreActionModel", ^{
            [page ArticleMoreActionModel: [CMSModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            page.selectModel = [CMSModel new];
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 1", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"},
                                    };
            page.selectModel = model;
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 1", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @""},
                                    };
            page.selectModel = model;
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 1", ^{
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"onClickItem", ^{
            [page onClickItem: [CMSModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"CategoryPickerSelectAction", ^{
            [page CategoryPickerSelectAction:@"action" categoryName:@"name"];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"ArticleMarkActionView", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = YES;
            [page ArticleMarkActionView: model view: [UIView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"ArticleMarkActionView with model not bookmark", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = NO;
            [page ArticleMarkActionView: model view: [UIView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [page scrollViewDidScroll: [UIScrollView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleTextFieldBlock", ^{
            [page handleTextFieldBlock: [UITextField new]];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
