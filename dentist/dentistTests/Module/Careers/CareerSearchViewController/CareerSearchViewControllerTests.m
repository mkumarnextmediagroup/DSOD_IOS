//
//  CareerSearchViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/9/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerSearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "FindJobsSponsorTableViewCell.h"

SPEC_BEGIN(CareerSearchViewControllerTests)
describe(@"Unit Test For CareerSearchViewController", ^{
    __block CareerSearchViewController *controller;

    beforeEach(^{
        controller = [CareerSearchViewController new];
    });

    context(@"methods", ^{
        it(@"makeHeaderView", ^{
            UIView *view = [controller makeHeaderView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"setJobCountTitle", ^{
            [controller setJobCountTitle:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"searchBtnClick", ^{
            [controller searchBtnClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [controller onBack:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:@"FindJobsSponsorTableViewCell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"textFieldShouldReturn", ^{
            BOOL shouldReturn = [controller textFieldShouldReturn:[UITextField new]];
            [[theValue(shouldReturn) should] equal: theValue(YES)];
        });

        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"createEmptyNotice", ^{
            [controller createEmptyNotice];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"createLocation", ^{
            [controller createLocation];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"createPickView", ^{
            [controller createPickView:[UITextField new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"getCurrentLocation", ^{
            [controller getCurrentLocation];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"textFieldShouldBeginEditing", ^{
            BOOL shouldReturn = [controller textFieldShouldBeginEditing:[UITextField new]];
            [[theValue(shouldReturn) should] equal: theValue(YES)];
        });

        it(@"didUpdateLocations", ^{
            id objects[] = { [CLLocation new] };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            [controller locationManager:[CLLocationManager new] didUpdateLocations:array];
            [[theValue(controller.view) shouldNot] beNil];
        });
        it(@"didFailWithError", ^{
            [controller locationManager:[CLLocationManager new] didFailWithError:[[NSError alloc] initWithDomain:@"domain" code:1000 userInfo:NULL]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
