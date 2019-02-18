//
//  AllowMultiGestureTableViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/16/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "AllowMultiGestureTableView.h"

SPEC_BEGIN(AllowMultiGestureTableViewTests)
describe(@"Unit Test For AllowMultiGestureTableView", ^{
    __block AllowMultiGestureTableView *tableView;

    beforeEach(^{
        tableView = [AllowMultiGestureTableView new];
    });

    context(@"methods", ^{
        it(@"gestureRecognizer", ^{
            BOOL shouldRecog = [tableView gestureRecognizer:[UIGestureRecognizer new] shouldRecognizeSimultaneouslyWithGestureRecognizer:[UIGestureRecognizer new]];
            [[theValue(shouldRecog) should] equal:theValue(YES)];
        });
    });
});
SPEC_END
