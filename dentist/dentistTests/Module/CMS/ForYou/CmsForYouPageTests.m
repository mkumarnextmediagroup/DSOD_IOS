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

        it(@"clickCloseAd", ^{
            [page clickCloseAd:NULL];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"onClickItem", ^{
            [page onClickItem:NULL];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"onClickItem", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"videos";
            [page onClickItem:model];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"getContentCachesData", ^{
            page.contenttype = @"contenttype";
            [page getContentCachesData:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 0", ^{
            page.selectModel = [CMSModel new];
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 1", ^{
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 2", ^{
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:2];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 1 with selectModel", ^{
            page.selectModel = [CMSModel new];
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"myActionSheet with index 1 with selectModel, type = 1", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"},
                                    };
            page.selectModel = model;
            [page myActionSheet:NULL parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"didDentistSelectItemAtIndex", ^{
            page.segItemsModel = [[NSMutableArray alloc] init];
            [page.segItemsModel addObject:[IdName new]];
            [page.segItemsModel addObject:[IdName new]];
            [page didDentistSelectItemAtIndex:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"didDentistSelectItemAtIndex with IdName", ^{
            page.segItemsModel = [[NSMutableArray alloc] init];
            IdName *idName = [IdName new];
            idName.id = @"-1";
            [page.segItemsModel addObject:idName];
            [page.segItemsModel addObject:[IdName new]];
            [page didDentistSelectItemAtIndex:0];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handlePicker", ^{
            [page handlePicker:@"result" resultName:@"resultname"];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"handlePicker", ^{
            [page scrollViewDidScroll:[UIScrollView new]];
            [[theValue(page.view) shouldNot] beNil];
        });

        it(@"loadmore", ^{
            [page loadMore];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
