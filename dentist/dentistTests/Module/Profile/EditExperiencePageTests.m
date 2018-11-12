//
//  EditExperiencePageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/5/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "EditExperiencePage.h"
#import "Experience.h"

SPEC_BEGIN(EditExperiencePageTests)
describe(@"Unit Test for EditExperiencePage", ^{
    __block EditExperiencePage *controller;

    beforeEach(^{
        controller = [EditExperiencePage new];
    });

    context(@"Life Cycle", ^{

        context(@"With isAdd is True", ^{
            it(@"View Did Load With isAdd is True", ^{
                controller.isAdd = TRUE;
                [controller viewDidLoad];
                [[controller.view shouldNot] beNil];
            });


            it(@"View Did Load With Experience and typeName", ^{
                controller.isAdd = TRUE;
                Experience *ex = [Experience new];
                ex.praticeTypeId = @"123";
                ex.praticeType = @"Test Affiliated";
                controller.exp = ex;
                [controller viewDidLoad];
                [[controller.view shouldNot] beNil];
            });
        });

        context(@"With isAdd is False", ^{
            it(@"View Did Load With isAdd is False", ^{
                [controller viewDidLoad];
                [[controller.view shouldNot] beNil];
            });

            it(@"View Did Load With Experience and praticeTypeId", ^{
                Experience *ex = [Experience new];
                ex.praticeTypeId = @"123";
                controller.exp = ex;
                [controller viewDidLoad];
                [[controller.view shouldNot] beNil];
            });

            it(@"View Did Load With Experience and typeName", ^{
                Experience *ex = [Experience new];
                ex.praticeTypeId = @"123";
                ex.praticeType = @"Test Affiliated";
                controller.exp = ex;
                [controller viewDidLoad];
                [[controller.view shouldNot] beNil];
            });

            it(@"View Did Load With Experience and typeName and workInThisRole", ^{
                Experience *ex = [Experience new];
                ex.praticeTypeId = @"123";
                ex.praticeType = @"Test Affiliated";
                ex.workInThisRole = TRUE;
                controller.exp = ex;
                [controller viewDidLoad];
                [[controller.view shouldNot] beNil];
            });
        });

        context(@"Methods", ^{
            it(@"selectPracTypes", ^{
                [controller selectPracTypes:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickType", ^{
                [controller clickType:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"selectRoles", ^{
                [controller selectRoles:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickRole", ^{
                [controller clickRole:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"selectDSO", ^{
                [controller selectDSO:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickDental", ^{
                [controller clickDental:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"onSwitchChanged with switch on", ^{
                TitleSwitchView *switchView = [TitleSwitchView new];
                [switchView.switchView setOn:YES];
                controller.switchView = switchView;
                [controller onSwitchChanged:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"onSwitchChangedwith switch off", ^{
                TitleSwitchView *switchView = [TitleSwitchView new];
                [switchView.switchView setOn:NO];
                controller.switchView = switchView;
                [controller onSwitchChanged:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"bindData with empty dsoName", ^{
                controller.dsoView = [TitleMsgArrowView new];
                controller.dsoName = @"";
                [controller bindData];
                [[controller.view shouldNot] beNil];
            });

            it(@"bindData with dsoName", ^{
                controller.dsoView = [TitleMsgArrowView new];
                controller.dsoName = @"test";
                [controller bindData];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickFromDate", ^{
                [controller clickFromDate:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickToDate", ^{
                [controller clickToDate:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickCancel", ^{
                [controller clickCancel:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickDelete", ^{
                [controller clickDelete:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickBack", ^{
                [controller clickBack:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickSave", ^{
                [controller clickSave:NULL];
                [[controller.view shouldNot] beNil];
            });

            it(@"clickSave with currentWorking", ^{
                controller.currentWorking = YES;
                [controller clickSave:NULL];
                [[controller.view shouldNot] beNil];
            });
        });
    });
});

SPEC_END
