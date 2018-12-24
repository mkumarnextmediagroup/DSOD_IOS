//
//  DenActionSheetTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/24/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DenActionSheet.h"

SPEC_BEGIN(DenActionSheetTests)
describe(@"Unit Test For DenActionSheet", ^{
    __block DenActionSheet *sheet;

    beforeEach(^{
        sheet = [DenActionSheet new];
    });

    context(@"methods", ^{
        it(@"show", ^{
            [sheet show];
            [[theValue(sheet) shouldNot] beNil];
        });

        it(@"show superview", ^{
            UIView *view = [UIView new];
            [sheet show:view];
            [[theValue(sheet) shouldNot] beNil];
        });

        it(@"show superview", ^{
            [sheet show:NULL];
            [[theValue(sheet) shouldNot] beNil];
        });

        it(@"updateActionTitle", ^{
            id objects[] = { @"title", @"Hello World!", @"title", @"Hello World!", @"title", @"Hello World!"};
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            sheet.parentView = [UIView new];
            UILabel *label = [UILabel new];
            label.tag = 101;
            [sheet.parentView addSubview:label];
            label.tag = 102;
            [sheet.parentView addSubview:label];
            [sheet updateActionTitle:array];
            [[theValue(sheet) shouldNot] beNil];
        });

        it(@"initWithDelegate", ^{
            sheet = [sheet initWithDelegate:NULL title:@"title" cancelButton:@"cancel" imageArr:NULL otherTitle:@"ok", nil];
            [[theValue(sheet) shouldNot] beNil];
        });

        it(@"tapAction", ^{
            [sheet tapAction:NULL];
            [[theValue(sheet) shouldNot] beNil];
        });

        it(@"touchesBegan", ^{
            [sheet touchesBegan:NULL withEvent:NULL];
            [[theValue(sheet) shouldNot] beNil];
        });
    });
});
SPEC_END
