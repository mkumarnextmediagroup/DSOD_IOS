//
//  EducationCoursesViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/27/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationCoursesViewController.h"

SPEC_BEGIN(EducationCoursesViewControllerTests)
describe(@"Unit Test For EducationCoursesViewController", ^{
    __block EducationCoursesViewController *controller;

    beforeEach(^{
        controller = [EducationCoursesViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
