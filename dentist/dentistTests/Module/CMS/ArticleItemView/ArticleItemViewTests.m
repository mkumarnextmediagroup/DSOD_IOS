//
//  ArticleItemViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/19/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ArticleItemView.h"
#import "Article.h"
#import "CMSModel.h"

SPEC_BEGIN(ArticleItemViewTests)
describe(@"Unit Test For ArticleItemView", ^{
    __block ArticleItemView *view;

    beforeEach(^{
        view = [ArticleItemView new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"bind", ^{
            [view bind:[Article new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind article with VIDEOS", ^{
            Article *art = [Article new];
            art.categoryName = @"VIDEOS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind article with PODCASTS", ^{
            Article *art = [Article new];
            art.categoryName = @"PODCASTS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind article with INTERVIEWS", ^{
            Article *art = [Article new];
            art.categoryName = @"INTERVIEWS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind article with TECH GUIDES", ^{
            Article *art = [Article new];
            art.categoryName = @"TECH GUIDES";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind article with ANIMATIONS", ^{
            Article *art = [Article new];
            art.categoryName = @"ANIMATIONS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind article with TIP SHEETS", ^{
            Article *art = [Article new];
            art.categoryName = @"TIP SHEETS";
            art.isBookmark = TRUE;
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS", ^{
            [view bindCMS:[CMSModel new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"},
                                    };
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with contentType VIDEOS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"VIDEOS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with contentType TIP SHEETS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"TIP SHEETS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with contentType ANIMATIONS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"ANIMATIONS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with contentType TECH GUIDES", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"TECH GUIDES";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with contentType INTERVIEWS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"INTERVIEWS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with contentType PODCASTS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"PODCASTS";
            model.isBookmark = TRUE;
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });
//        -(void)showFilter;

        it(@"updateBookmarkStatus TRUE", ^{
            [view updateBookmarkStatus:TRUE];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"updateBookmarkStatus FALSE", ^{
            [view updateBookmarkStatus:FALSE];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"getSeparatedLinesFromLabel", ^{
            [view getSeparatedLinesFromLabel:[UILabel new] text:@"test"];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"moreAction", ^{
            [view moreAction:NULL];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"moreAction", ^{
            [view markAction:NULL];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"showFilter", ^{
            [view showFilter];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
