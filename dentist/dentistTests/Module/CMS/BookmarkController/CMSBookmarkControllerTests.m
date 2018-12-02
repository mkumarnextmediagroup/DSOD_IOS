//
//  CMSBookmarkController.m
//  dentistTests
//
//  Created by Su Ho V. on 12/1/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsBookmarkController.h"
#import "BookMarkItemView.h"
#import "BookmarkModel.h"
#import "HttpResult.h"

SPEC_BEGIN(CmsBookmarkControllerTests)
describe(@"Unit Test For CmsBookmarkController", ^{
    __block CmsBookmarkController *controller;

    beforeEach(^{
        controller = [CmsBookmarkController new];
    });

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            [controller viewWillAppear:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"updateFilterView", ^{
            (void) [[UINavigationController alloc] initWithRootViewController:controller];
            [controller updateFilterView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"updateFilterView", ^{
            (void) [[UINavigationController alloc] initWithRootViewController:controller];
            controller.categoryId = @"id";
            [controller updateFilterView];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewClassOfItem", ^{
            Class cls = [controller viewClassOfItem:NULL];
            [[cls should] equal:BookMarkItemView.class];
        });

        it(@"viewClassOfItem", ^{
            CGFloat height = [controller heightOfItem:NULL];
            [[theValue(height) should] equal:theValue(controller.rowheight)];
        });

        it(@"onBindItem", ^{
            [controller onBindItem:[BookmarkModel new] view:[BookMarkItemView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"BookMarkActionModel", ^{
            BookmarkModel *model = [BookmarkModel new];
            [controller BookMarkActionModel:model];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"handleDeleteBookmarkWithResult", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":0}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            BookmarkModel *model = [BookmarkModel new];
            [controller handleDeleteBookmarkWithResult:result and:model];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"handleDeleteBookmarkWithResult with Failure", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            BookmarkModel *model = [BookmarkModel new];
            [controller handleDeleteBookmarkWithResult:result and:model];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onClickItem", ^{
            [controller onClickItem:NULL];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"clickFilter", ^{
            [controller clickFilter:NULL];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:NULL];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"handleSelectFilterWithCategory", ^{
            [controller handleSelectFilterWithCategory:@"category" andType:@"type"];
            [[controller.categoryId should] equal:@"category"];
            [[controller.contentTypeId should] equal:@"type"];
        });

        it(@"handleQueryBookmarks", ^{
            NSMutableArray *resultArray = [NSMutableArray array];
            [resultArray addObject:[BookmarkModel new]];
            [controller handleQueryBookmarks:resultArray];
            [[theValue(controller.items.count) should] equal:theValue(resultArray.count)];
        });

        it(@"handleLoadmore", ^{
            NSMutableArray *resultArray = [NSMutableArray array];
            [resultArray addObject:[BookmarkModel new]];
            [controller handleLoadmore:resultArray];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
