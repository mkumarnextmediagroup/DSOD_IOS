//
//  CareerAlertsAddViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/8/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CareerAlertsAddViewController.h"
#import "JobAlertsModel.h"

SPEC_BEGIN(CareerAlertsAddViewControllerTests)
describe(@"Unit Test For CareerAlertsAddViewController", ^{
    __block CareerAlertsAddViewController *controller;

    beforeEach(^{
        controller = [CareerAlertsAddViewController new];
    });

    context(@"methods", ^{
        it(@"setModel", ^{
            JobAlertsModel *model = [JobAlertsModel new];
            [controller setModel:model];
            [[theValue(controller.model) should] equal:theValue(model)];
        });

        it(@"onTap", ^{
            [controller onTap:controller.view];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onback", ^{
            [controller onback];
            [[theValue(controller.view) shouldNot] beNil];
        });


//        - (UIView *)makeFooterView;
//        - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//        - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//        - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//        - (void)clickSave:(UIButton *)sender;
//        - (void)getCurrentLocation;
//        - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
//        - (void)textFieldDidBeginEditing:(UITextField *)textField;
//        - (BOOL)textFieldShouldReturn:(UITextField *)textField;
//        - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;
//        - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
    });
});
SPEC_END
