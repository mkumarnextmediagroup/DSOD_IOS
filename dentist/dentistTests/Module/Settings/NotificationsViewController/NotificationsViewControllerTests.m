//
//  NotificationsViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "NotificationsViewController.h"
#import "NotificationsTableViewCell.h"

SPEC_BEGIN(NotificationsViewControllerTests)
describe(@"Unit Test For NotificationsViewController", ^{
    __block NotificationsViewController *controller;
    
    beforeEach(^{
        controller = [NotificationsViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"back", ^{
            [controller back];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:ip];
            [[theValue(height) should] equal:theValue(80)];
        });
        
        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(4)];
        });
        
        
        it(@"cellForRowAtIndexPath", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[NotificationsTableViewCell class] forCellReuseIdentifier:@"NotificationsTableViewCell"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });
        
        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller) shouldNot] beNil];
        });
        
        it(@"SwitchChangeAction", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller SwitchChangeAction:YES indexPath:indexPath view:[NotificationsTableViewCell new]];
            [[theValue(controller) shouldNot] beNil];
        });
    });
});
SPEC_END
