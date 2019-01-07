//
//  UniteThumCollectionViewCellTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UniteThumCollectionViewCell.h"
#import "DetailModel.h"
#import "MagazineModel.h"

SPEC_BEGIN(UniteThumCollectionViewCellTests)
describe(@"Unit Test For UniteThumCollectionViewCell", ^{
    __block UniteThumCollectionViewCell *cell;

    beforeEach(^{
        cell = [UniteThumCollectionViewCell new];
    });

    context(@"methods", ^{
        it(@"bind", ^{
            [cell bind:[DetailModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"initWithFrame", ^{
            cell = [cell initWithFrame:CGRectMake(0, 0, 100, 100)];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"buildView", ^{
            [cell buildView];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"buildTitleView", ^{
            [cell buildTitleView];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"buildSwipeView", ^{
            [cell buildSwipeView];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"showAD", ^{
            [cell showAD:[MagazineModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"showCover", ^{
            [cell showCover:[MagazineModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"showIntroduction", ^{
            [cell showIntroduction:[DetailModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"showActicle", ^{
            [cell showActicle:[DetailModel new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"calcWebViewHeight", ^{
            [cell calcWebViewHeight:[NSTimer timerWithTimeInterval:0.3 target:self selector:NULL userInfo:NULL repeats:FALSE]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"webViewDidFinishLoad", ^{
            [cell webViewDidFinishLoad:[UIWebView new]];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didFailLoadWithError", ^{
            NSError *error = [[NSError alloc] initWithDomain:@"domain" code:100 userInfo:NULL];
            [cell webView:[UIWebView new] didFailLoadWithError:error];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"scrollViewDidScroll", ^{
            [cell scrollViewDidScroll:[UIScrollView new]];
            [[theValue(cell) shouldNot] beNil];
        });
    });
});
SPEC_END
