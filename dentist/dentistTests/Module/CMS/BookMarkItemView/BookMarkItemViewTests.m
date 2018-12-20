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

        it(@"bind with VIDEOS", ^{
            Article *art = [Article new];
            art.categoryName = @"VIDEOS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with PODCASTS", ^{
            Article *art = [Article new];
            art.categoryName = @"PODCASTS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with INTERVIEWS", ^{
            Article *art = [Article new];
            art.categoryName = @"INTERVIEWS";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with TECH GUIDES", ^{
            Article *art = [Article new];
            art.categoryName = @"TECH GUIDES";
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with ANIMATIONS", ^{
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

        it(@"bindCMS with VIDEOS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"VIDEOS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with PODCASTS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"PODCASTS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with INTERVIEWS", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"INTERVIEWS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with TECH GUIDES", ^{
            BookmarkModel *model = [BookmarkModel new];
            model.contentTypeName = @"TECH GUIDES";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with ANIMATIONS", ^{
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
