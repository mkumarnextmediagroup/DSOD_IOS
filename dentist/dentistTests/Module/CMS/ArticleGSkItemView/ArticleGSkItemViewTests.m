//
//  ArticleGSkItemViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ArticleGSkItemView.h"
#import "Article.h"
#import "CMSModel.h"

SPEC_BEGIN(ArticleGSkItemViewTests)
describe(@"Unit Test For ArticleGSkItemView", ^{
    __block ArticleGSkItemView *view;

    beforeEach(^{
        view = [ArticleGSkItemView new];
    });

    context(@"methods", ^{
        it(@"bind", ^{
            [view bind:[Article new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with VIDEOS", ^{
            Article *art = [Article new];
            art.categoryName = @"VIDEOS";
            art.isBookmark = TRUE;
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
            CMSModel *model = [CMSModel new];
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS sponsorId 260", ^{
            CMSModel *model = [CMSModel new];
            model.sponsorId = @"260";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS sponsorId 260", ^{
            CMSModel *model = [CMSModel new];
            model.sponsorId = @"260";
            model.isBookmark = TRUE;
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

//        - (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label text:(NSString *)text

        it(@"getSeparatedLinesFromLabel", ^{
            NSArray *array = [view getSeparatedLinesFromLabel:[UILabel new] text:@"string"];
            [[theValue(array.count) should] equal:theValue(6)];
        });
    });
});
SPEC_END
