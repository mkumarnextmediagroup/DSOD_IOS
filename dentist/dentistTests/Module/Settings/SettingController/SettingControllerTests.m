//
//  SettingControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "SettingController.h"

SPEC_BEGIN(SettingControllerTests)
describe(@"Unit Test For SettingController", ^{
    __block SettingController *controller;
    
    beforeEach(^{
        controller = [SettingController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        
        it(@"heightForRowAtIndexPath", ^{ 
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:ip];
            [[theValue(height) should] equal:theValue(55)];
        });
        
        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [controller numberOfSectionsInTableView:[UITableView new]];
            [[theValue(num) should] equal:theValue(2)];
        });
        
        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:1];
            [[theValue(height) should] equal:theValue(100)];
        });
        
        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });
        
        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });
        
        
        it(@"cellForRowAtIndexPath", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });
        
        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller) shouldNot] beNil];
        });
        
        it(@"onClickLogout", ^{
            [controller onClickLogout:nil];
            [[theValue(controller) shouldNot] beNil];
        });
    });
});
SPEC_END
