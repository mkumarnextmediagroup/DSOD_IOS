//
//  SearchPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/3/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//
#import "Kiwi.h"
#import "SearchPage.h"
#import "LabelCheckView.h"
#import "Pair.h"

SPEC_BEGIN(SearchPageTests)

describe(@"Unit Test For Search Page on Edit Profile", ^{
    __block SearchPage *controller;

    beforeEach(^{
        controller = [SearchPage new];
    });

    context(@"Life Cycle", ^{
        it(@"init", ^{
            [[theValue(controller.withGroupLabel) should] equal:theValue(NO)];
            [[theValue(controller.withIndexBar) should] equal:theValue(YES)];
            [[controller.titleText should] equal:@"Select"];
        });

        it(@"view did load", ^{
            [controller viewDidLoad];
            [[controller.searchEdit shouldNot] beNil];
        });
    });

    context(@"Methods of Search Page", ^{
        it(@"onTextFieldDone", ^{
            [controller onTextFieldDone:controller.searchEdit];
            [[controller.view shouldNot] beNil];
        });
        it(@"click Back", ^{
            [controller clickBack:controller];
            [[controller.view shouldNot] beNil];
        });

        it(@"viewClassOfItem", ^{
            Class cls = [controller viewClassOfItem:NULL];
            [[cls should] equal:LabelCheckView.class];
        });

        it(@"heightOfItem", ^{
            CGFloat height = [controller heightOfItem:controller];
            [[theValue(height) should] equal:theValue(44)];
        });

        it(@"onBindItem", ^{
            [controller onBindItem:controller view:[LabelCheckView new]];
            [[controller.view shouldNot] beNil];
        });

        it(@"onBindItem with disPlayBlock not nil", ^{
            controller.displayBlock = ^NSString *(NSObject *obj) {
                return @"";
            };
            [controller onBindItem:controller view:[LabelCheckView new]];
            [[controller.view shouldNot] beNil];
        });

        it(@"onBindItem with item is NSString", ^{
            [controller onBindItem:@"str" view:[LabelCheckView new]];
            [[controller.view shouldNot] beNil];
        });

        it(@"onBindItem with item is Pair", ^{
            [controller onBindItem:[Pair new] view:[LabelCheckView new]];
            [[controller.view shouldNot] beNil];
        });

        it(@"onClickItem with onResult nil", ^{
            [controller onClickItem:controller];
            [[controller.view shouldNot] beNil];
        });

        it(@"onClickItem with onResult not nil", ^{
            controller.onResult = ^(NSObject *item) {};
            [controller onClickItem:controller];
            [[controller.view shouldNot] beNil];
        });
    });
});

SPEC_END
