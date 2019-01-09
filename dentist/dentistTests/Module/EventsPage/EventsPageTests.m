//
//  EventsPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/7/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EventsPage.h"

SPEC_BEGIN(EventsPageTests)
describe(@"Unit Test For EventsPage", ^{
    __block EventsPage *page;

    beforeEach(^{
        page = [EventsPage new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [page viewDidLoad];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
