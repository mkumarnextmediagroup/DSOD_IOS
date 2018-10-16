//
//  KiwiTests.m
//  dentistTests
//
//  Created by Su Ho V. on 10/17/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(KiwiTests)

describe(@"Example String", ^{
    it(@"Equal String", ^{
        NSString *str1 = @"testExample";
        NSString *str2 = @"testExample";
        [[theValue(str1) should] equal:theValue(str2)];
    });
});

SPEC_END

