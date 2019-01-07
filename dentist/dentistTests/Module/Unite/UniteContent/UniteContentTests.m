//
//  UniteContentTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UniteContent.h"

SPEC_BEGIN(UniteContentTests)
describe(@"Unit Test For UniteContent", ^{
    __block UniteContent *content;

    beforeEach(^{
        content = [UniteContent new];
    });

    context(@"methods", ^{
        it(@"webViewDidFinishLoad", ^{
            [content webViewDidFinishLoad:[UIWebView new]];
            [[theValue(content) shouldNot] beNil];
        });
    });
});
SPEC_END
