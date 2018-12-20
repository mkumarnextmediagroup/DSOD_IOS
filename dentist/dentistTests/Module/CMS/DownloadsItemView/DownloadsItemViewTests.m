//
//  DownloadsItemViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/20/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DownloadsItemView.h"
#import "Article.h"
#import "CMSModel.h"

SPEC_BEGIN(DownloadsItemViewTests)
describe(@"Unit Test For DownloadsItemView", ^{
    __block DownloadsItemView *view;

    beforeEach(^{
        view = [DownloadsItemView new];
    });

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

        it(@"manager", ^{
            AFURLSessionManager *manager = [view manager];
            [[theValue(manager) shouldNot] beNil];
        });

        it(@"bindCMS", ^{
            [view bindCMS:[CMSModel new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with VIDEOS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"VIDEOS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with PODCASTS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"PODCASTS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with INTERVIEWS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"INTERVIEWS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with TECH GUIDES", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"TECH GUIDES";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with ANIMATIONS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"ANIMATIONS";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with TIP SHEETS", ^{
            CMSModel *model = [CMSModel new];
            model.contentTypeName = @"TIP SHEETS";
            model.featuredMediaId = @"mediaId";
            model.downstatus = @"5";
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

//        -(void)updateProgressView:(CGFloat)val;
//        -(void)moreAction:(UIButton *)sender;

        it(@"updateProgressView", ^{
            [view updateProgressView:10];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
