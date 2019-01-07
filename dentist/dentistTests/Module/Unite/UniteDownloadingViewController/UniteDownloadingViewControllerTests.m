//
//  UniteDownloadingViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/6/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UniteDownloadingViewController.h"
#import "MagazineModel.h"

SPEC_BEGIN(UniteDownloadingViewControllerTests)
describe(@"Unit Test For UniteDownloadingViewController", ^{
    __block UniteDownloadingViewController *controller;

    beforeEach(^{
        controller = [UniteDownloadingViewController new];
    });

    context(@"methods", ^{
        it(@"rightBtnClick", ^{
            [controller rightBtnClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"downloadBtnAction", ^{
            [controller downloadBtnAction];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"loadData", ^{
            [controller loadData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"downloadData", ^{
            [controller downloadData];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [controller onBack:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
