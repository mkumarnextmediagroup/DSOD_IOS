//
//  CmsForYouPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CmsForYouPage.h"
#import "ArticleItemView.h"
#import "ArticleGSkItemView.h"

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

        it(@"showImageBrowser", ^{
            [page ArticleMoreActionModel:[CMSModel new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"ArticleMarkActionView with model is not bookmark", ^{
            CMSModel *model = [CMSModel new];
            [page ArticleMarkActionView:model view:[UIView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"ArticleMarkActionView with model is bookmark", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = 1;
            [page ArticleMarkActionView:model view:[UIView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleDeleteBookmark", ^{
            HttpResult *result = [HttpResult new];
            CMSModel *model = [CMSModel new];
            UIView *view = [UIView new];
            [page handleDeleteBookmark:result model:model view:view];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleDeleteBookmark with result OK", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":0}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            CMSModel *model = [CMSModel new];
            UIView *view = [ArticleItemView new];
            [page handleDeleteBookmark:result model:model view:view];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleDeleteBookmark with result OK and model have model.sponsorId", ^{
            HttpResult *result = [HttpResult new];
            NSURL *url = [[NSURL alloc] initWithString:@"http://www.example.com"];
            result.response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:NULL headerFields:NULL];
            NSString *str = @"{\"code\":0}";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            result.data = data;
            CMSModel *model = [CMSModel new];
            model.sponsorId = @"123";
            UIView *view = [ArticleGSkItemView new];
            [page handleDeleteBookmark:result model:model view:view];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handleAddBookmark", ^{
            HttpResult *result = [HttpResult new];
            CMSModel *model = [CMSModel new];
            UIView *view = [UIView new];
            [page handleAddBookmark:result model:model view:view];
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
            UIView *view = [ArticleItemView new];
            [page handleAddBookmark:result model:model view:view];
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
            UIView *view = [ArticleItemView new];
            [page handleAddBookmark:result model:model view:view];
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
            UIView *view = [ArticleItemView new];
            [page handleAddBookmark:result model:model view:view];
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
            [page handleAddBookmark:result model:model view:view];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"ArticleGSKActionModel", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = 1;
            [page ArticleGSKActionModel:model];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
