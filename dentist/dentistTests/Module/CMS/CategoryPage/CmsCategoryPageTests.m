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

//        - (void)refreshData;
//        - (void)ArticleMoreActionModel:(CMSModel *)model;
//        - (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
//        - (void)onClickItem:(NSObject *)item;
//        - (void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName;
//        - (void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view;
//        - (void)scrollViewDidScroll:(UIScrollView *)scrollView;


    });
});
SPEC_END
