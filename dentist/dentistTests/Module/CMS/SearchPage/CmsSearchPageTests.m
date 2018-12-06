//
//  CmsSearchPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/4/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsSearchPage.h"
#import "ArticleGSkItemView.h"
#import "CMSModel.h"
#import "DenActionSheet.h"
#import "HttpResult.h"

SPEC_BEGIN(CmsSearchPageTests)
describe(@"Unit Test For CmsSearchPage", ^{
    __block CmsSearchPage *page;

    beforeEach(^{
        page = [CmsSearchPage new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"viewWillAppear", ^{
            page.isRefresh = NO;
            [page viewWillAppear:TRUE];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"viewDidLoad", ^{
            [page viewDidLoad];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
        });

        it(@"refreshData", ^{
            [page refreshData];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"refreshData", ^{
            page.items = @[@"1", @"2", @"2"];
            [page refreshData];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
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
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"ArticleMoreActionModel", ^{
            [page ArticleMoreActionModel:[CMSModel new]];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"onClickItem", ^{
            [page onClickItem:[CMSModel new]];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"myActionSheet with index 0", ^{
            page.selectModel = [CMSModel new];
            [page myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"myActionSheet with index 1", ^{
            [page myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
        });

        it(@"myActionSheet with index 1 with model", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"},
                                    };
            page.selectModel = model;
            [page myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"myActionSheet with index 1 with model", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1"};
            page.selectModel = model;
            [page myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"ArticleMarkActionView", ^{
            [page ArticleMarkActionView:[CMSModel new] view:[ArticleGSkItemView new]];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"ArticleMarkActionView with model is a bookmark", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = 1;
            [page ArticleMarkActionView:model view:[ArticleGSkItemView new]];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"searchBarShouldBeginEditing", ^{
            [page searchBarShouldBeginEditing: NULL];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"searchBarCancelButtonClicked", ^{
            [page searchBarCancelButtonClicked: NULL];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"searchBarSearchButtonClicked", ^{
            [page searchBarSearchButtonClicked: NULL];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
        });

        it(@"scrollViewDidScroll", ^{
            [page scrollViewDidScroll: NULL];
            [[theValue(page.isRefresh) should] equal:theValue(YES)];
        });

        it(@"cancelBtnClick", ^{
            [page cancelBtnClick: NULL];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"CategoryPickerSelectAction", ^{
            [page CategoryPickerSelectAction:@"id" categoryName:@"name"];
            [[theValue(page.isRefresh) should] equal:theValue(NO)];
        });

        it(@"handleDeleteBookmark", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":0}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            [page handleDeleteBookmark:result view:[ArticleGSkItemView new] model:[CMSModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleDeleteBookmark with Failure", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            [page handleDeleteBookmark:result view:[ArticleGSkItemView new] model:[CMSModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleAddBookmark", ^{
            HttpResult *result = [HttpResult new];
            CMSModel *model = [CMSModel new];
            UIView *view = [UIView new];
            [page handleAddBookmark:result view:view model:model];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleAddBookmark with result OK", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":0}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            CMSModel *model = [CMSModel new];
            UIView *view = [ArticleGSkItemView new];
            [page handleAddBookmark:result view:view model:model];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleAddBookmark with result code is 2003", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":2033}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            CMSModel *model = [CMSModel new];
            UIView *view = [ArticleGSkItemView new];
            [page handleAddBookmark:result view:view model:model];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleAddBookmark with result code is 2003 and model.sponsorId", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":2033}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            CMSModel *model = [CMSModel new];
            model.sponsorId = @"123";
            UIView *view = [ArticleGSkItemView new];
            [page handleAddBookmark:result view:view model:model];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleAddBookmark with result OK and model have model.sponsorId", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":0}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            CMSModel *model = [CMSModel new];
            model.sponsorId = @"123";
            UIView *view = [ArticleGSkItemView new];
            [page handleAddBookmark:result view:view model:model];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
