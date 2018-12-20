//
//  GSKItemViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/20/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "GSKItemView.h"
#import "Article.h"
#import "CMSModel.h"

SPEC_BEGIN(GSKItemViewTests)
describe(@"Unit Test For GSKItemView", ^{
    __block GSKItemView *view;

    beforeEach(^{
        view = [GSKItemView new];
    });

    context(@"methods", ^{
        it(@"bind", ^{
            [view bind:[Article new]];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind isBookmark true", ^{
            Article *art = [Article new];
            art.isBookmark = TRUE;
            [view bind:art];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS", ^{
            CMSModel *model = [CMSModel new];
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with bookmark", ^{
            CMSModel *model = [CMSModel new];
            model.isBookmark = TRUE;
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bindCMS with type 1", ^{
            CMSModel *model = [CMSModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"},
                                    };
            [view bindCMS:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"updateBookmark status with true", ^{
            [view updateBookmarkStatus:TRUE];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"updateBookmark status with false", ^{
            [view updateBookmarkStatus:FALSE];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"showFilter", ^{
            [view showFilter];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
