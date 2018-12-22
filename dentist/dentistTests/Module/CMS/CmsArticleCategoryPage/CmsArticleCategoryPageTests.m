//
//  CmsArticleCategoryPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsArticleCategoryPage.h"
#import "ArticleGSkItemView.h"
#import "ArticleItemView.h"
#import "DenActionSheet.h"

SPEC_BEGIN(CmsArticleCategoryPageTests)
describe(@"Unit Test For CmsArticleCategoryPage", ^{
    __block CmsArticleCategoryPage *controller;

    beforeEach(^{
        controller = [CmsArticleCategoryPage new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewWillAppear", ^{
            [controller viewWillAppear:YES];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"hideCmsIndicator", ^{
            [controller hideCmsIndicator];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [controller onBack:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewClassOfItem", ^{
            Class cls = [controller viewClassOfItem:[NSObject new]];
            [[theValue(cls) should] equal:theValue(ArticleGSkItemView.class)];
        });

        it(@"heightOfItem", ^{
            CGFloat height = [controller heightOfItem:[NSObject new]];
            [[theValue(height) should] equal:theValue(UITableViewAutomaticDimension)];
        });

        it(@"onBindItem", ^{
            [controller onBindItem:[CMSModel new] view:[ArticleGSkItemView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onClickItem", ^{
            [controller onClickItem:[CMSModel new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onClickItem", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"videos";
            [controller onClickItem:model];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"refreshData", ^{
            [controller refreshData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"ArticleMoreActionModel", ^{
            [controller ArticleMoreActionModel:[CMSModel new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"ArticleMarkActionView", ^{
            [controller ArticleMarkActionView:[CMSModel new] view:[ArticleItemView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"ArticleMarkActionView", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = true;
            [controller ArticleMarkActionView:model view:[ArticleItemView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            [controller myActionSheet: [DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            controller.selectModel = [CMSModel new];
            [controller myActionSheet: [DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            [controller myActionSheet: [DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            controller.selectModel = [CMSModel new];
            [controller myActionSheet: [DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"CategoryPickerSelectAction", ^{
            [controller CategoryPickerSelectAction:@"" categoryName:@"name"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
