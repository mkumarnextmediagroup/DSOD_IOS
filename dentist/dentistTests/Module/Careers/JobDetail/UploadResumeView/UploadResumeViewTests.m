//
//  UploadResumeViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/21/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "UploadResumeView.h"

SPEC_BEGIN(UploadResumeViewTests)
describe(@"Unit Test For UploadResumeView", ^{
    __block UploadResumeView *view;

    beforeEach(^{
        view = [UploadResumeView new];
    });

    context(@"methods", ^{
        it(@"show", ^{
            [view show];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"scrollToSubmit", ^{
            [view scrollToSubmit];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"scrollToDone", ^{
            [view scrollToDone:YES];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"sigleTappedPickerView", ^{
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NULL];
            [view sigleTappedPickerView:tapGesture];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"closeBtnClick", ^{
            [view closeBtnClick];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"initUploadView", ^{
            [view initUploadView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"createDoneView", ^{
            [view createDoneView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"okBtnClick", ^{
            [view okBtnClick];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"uploadBtnClick", ^{
            [view uploadBtnClick:[UIButton new]];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
