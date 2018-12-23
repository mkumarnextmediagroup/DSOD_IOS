//
//  RMDisplayLabelTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/23/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "RMDisplayLabel.h"

SPEC_BEGIN(RMDisplayLabelTests)
describe(@"Unit Test For RMDisplayLabel", ^{
    __block RMDisplayLabel *label;

    beforeEach(^{
        label = [RMDisplayLabel new];
        label.text = @"100";
    });

    context(@"methods", ^{
        it(@"updateValue", ^{
            [label updateValue:100];
            [[label.text should] equal: [NSString stringWithFormat:@"%i",(int)(100 * 100)]];
        });

        it(@"addUpTimer", ^{
            [label updateValue:100];
            [label addUpTimer];
            [[label.text should] equal: [NSString stringWithFormat:@"%i",(int)(101)]];
        });
    });
});
SPEC_END
