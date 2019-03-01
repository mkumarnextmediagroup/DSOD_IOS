//
//  EducationSpeakerDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 2/27/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EducationSpeakerDetailViewController.h"
#import "AuthorModel.h"

SPEC_BEGIN(EducationSpeakerDetailViewControllerTests)
describe(@"Unit Test For EducationSpeakerDetailViewController", ^{
    __block EducationSpeakerDetailViewController *controller;

    beforeEach(^{
        controller = [EducationSpeakerDetailViewController new];
    });

    context(@"methods", ^{
        it(@"openBy", ^{
            UIViewController *controller = [[UIViewController alloc] init];
            [EducationSpeakerDetailViewController openBy:controller authorId:@"id"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"addNavBar", ^{
            [controller addNavBar];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"buildViews", ^{
            [controller buildViews];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"loadData", ^{
            [controller loadData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"showData", ^{
            [controller showData: [AuthorModel new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
