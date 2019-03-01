//
//  EducationDownloadsViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/27/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationDownloadsViewController.h"

SPEC_BEGIN(EducationDownloadsViewControllerTests)
describe(@"Unit Test For EducationDownloadsViewController", ^{
    __block EducationDownloadsViewController *controller;

    beforeEach(^{
        controller = [EducationDownloadsViewController new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
