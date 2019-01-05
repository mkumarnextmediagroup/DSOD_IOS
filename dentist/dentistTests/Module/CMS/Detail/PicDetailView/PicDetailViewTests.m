//
//  PicDetailViewTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/25/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "PicDetailView.h"
#import "DetailModel.h"

SPEC_BEGIN(PicDetailViewTests)
describe(@"Unit Test For PicDetailView", ^{
    __block PicDetailView *view;

    beforeEach(^{
        view = [PicDetailView new];
    });

    context(@"methods", ^{
        it(@"bind ", ^{
            id objects[] = {};
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            DetailModel *model = [DetailModel new];
            model.photoUrls = array;
            [view bind: model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"bind with data", ^{
            id objects[] = {@{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"}};
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *photoUrls = [NSArray arrayWithObjects:objects
                                                 count:count];
            DetailModel *model = [DetailModel new];
            model.photoUrls = photoUrls;
            [view bind: model];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"timerInvalidate", ^{
            [view timerInvalidate];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"imgBtnClick", ^{
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:imageView action:NULL];
            tap.view.tag = 10;
            [view imgBtnClick:tap];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
