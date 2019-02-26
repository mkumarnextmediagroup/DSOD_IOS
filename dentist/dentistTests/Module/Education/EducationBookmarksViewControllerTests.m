//
//  EducationBookmarksViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/24/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationBookmarksViewController.h"

SPEC_BEGIN(EducationBookmarksViewControllerTests)
describe(@"Unit Test For EducationBookmarksViewController", ^{
    __block EducationBookmarksViewController *controller;

    beforeEach(^{
        controller = [EducationBookmarksViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
