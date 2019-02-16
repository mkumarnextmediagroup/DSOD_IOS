//
//  FeedbackAndSupportViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "FeedbackAndSupportViewController.h"

SPEC_BEGIN(FeedbackAndSupportViewControllerTests)
describe(@"Unit Test For FeedbackAndSupportViewController", ^{
    __block FeedbackAndSupportViewController *controller;
    
    beforeEach(^{
        controller = [FeedbackAndSupportViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [FeedbackAndSupportViewController openBy:[UIViewController new]];
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
        
        
        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });
        
        it(@"cellForRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });
        
        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
