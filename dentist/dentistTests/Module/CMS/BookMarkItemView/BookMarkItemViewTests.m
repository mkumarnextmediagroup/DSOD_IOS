//
//  BookMarkItemViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/19/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "BookMarkItemView.h"
#import "Article.h"
#import "BookmarkModel.h"

SPEC_BEGIN(BookMarkItemViewTests)
describe(@"Unit Test For BookMarkItemView", ^{
    __block BookMarkItemView *view;

    beforeEach(^{
        view = [BookMarkItemView new];
    });

    context(@"properties", ^{});

    context(@"methods", ^{
        it(@"bind", ^{
            [view bind:[Article new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind iwth VIDEOS", ^{
            Article *art = [Article new];
            art.categoryName = @"VIDEOS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind iwth PODCASTS", ^{
            Article *art = [Article new];
            art.categoryName = @"PODCASTS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind iwth INTERVIEWS", ^{
            Article *art = [Article new];
            art.categoryName = @"INTERVIEWS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind iwth TECH GUIDES", ^{
            Article *art = [Article new];
            art.categoryName = @"TECH GUIDES";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind iwth ANIMATIONS", ^{
            Article *art = [Article new];
            art.categoryName = @"ANIMATIONS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with TIP SHEETS", ^{
            Article *art = [Article new];
            art.categoryName = @"TIP SHEETS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS", ^{
            [view bindCMS:[BookmarkModel new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS iwth VIDEOS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"VIDEOS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS iwth PODCASTS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"PODCASTS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS iwth INTERVIEWS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"INTERVIEWS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS iwth TECH GUIDES", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"TECH GUIDES";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS iwth ANIMATIONS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"ANIMATIONS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with TIP SHEETS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.coverthumbnailUrl = @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg";
            model.contentTypeName = @"TIP SHEETS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"markAction", ^{
            [view markAction:NULL];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
