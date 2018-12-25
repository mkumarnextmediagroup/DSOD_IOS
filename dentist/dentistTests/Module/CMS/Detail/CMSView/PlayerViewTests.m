//
//  PlayerViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/25/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "PlayerView.h"
#import "DetailModel.h"

SPEC_BEGIN(PlayerViewTests)
describe(@"Unit Test For PlayerView", ^{
    __block PlayerView *view;

    beforeEach(^{
        view = [PlayerView new];
    });

    context(@"methods", ^{
        it(@"bind", ^{
            DetailModel *model = [DetailModel new];
            [view bind:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind", ^{
            DetailModel *model = [DetailModel new];
            id objects[] = { @"video url" };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            model.isBookmark = TRUE;
            view.authorDSODentist = TRUE;
            model.videos = array;
            [view bind:model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"resetLayout", ^{
            [view resetLayout];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"htmlString", ^{
            NSString *str = [view htmlString: @"<p>asdasd</p><p>asdasd</p><p>asdasd</p>"];
            [[str shouldNot] beNil];
        });

        it(@"webViewDidFinishLoad", ^{
            view.mywebView = [UIWebView new];
            [view webViewDidFinishLoad:view.mywebView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"webKit didFinishNavigation", ^{
            WKWebView *webView = [WKWebView new];
            [view webView:webView didFinishNavigation:NULL];
            [[theValue(view) shouldNot] beNil];
        });
        it(@"handleCompletion", ^{
            [view handleCompletion:[WKWebView new] result:NULL];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"handleCompletionJavascript", ^{
            [view handleCompletionJavaScript:NULL ratio:10];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
