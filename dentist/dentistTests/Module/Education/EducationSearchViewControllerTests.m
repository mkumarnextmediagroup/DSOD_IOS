//
//  EducationSearchViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/27/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationSearchViewController.h"

SPEC_BEGIN(EducationSearchViewControllerTests)
describe(@"Unit Test For EducationSearchViewController", ^{
    __block EducationSearchViewController *controller;

    beforeEach(^{
        controller = [EducationSearchViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
