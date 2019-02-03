//
//  FAQSViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "FAQSViewController.h"
#import "FAQSTableViewCell.h"

SPEC_BEGIN(FAQSViewControllerTests)
describe(@"Unit Test For FAQSViewController", ^{
    __block FAQSViewController *controller;
    
    beforeEach(^{
        controller = [FAQSViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [FAQSViewController openBy:[UIViewController new] categoryModel:[FAQSCategoryModel new]];
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
        
        it(@"buttonOnClick", ^{
            [controller buttonOnClick];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        
        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });
        
        it(@"cellForRowAtIndexPath", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[FAQSTableViewCell class] forCellReuseIdentifier:@"FAQSTableViewCell"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });
        
    });
});
SPEC_END
