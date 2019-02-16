//
//  HelpAndFeedbackViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "HelpAndFeedbackViewController.h"
#import "FAQSCategoryModel.h"
#import "FAQSCategoryTableViewCell.h"

SPEC_BEGIN(HelpAndFeedbackViewControllerTests)
describe(@"Unit Test For HelpAndFeedbackViewController", ^{
    __block HelpAndFeedbackViewController *controller;
    
    beforeEach(^{
        controller = [HelpAndFeedbackViewController new];
    });
    
    afterEach(^{
//        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [HelpAndFeedbackViewController openBy:[UIViewController new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"viewDidLoad", ^{
            [controller viewDidLoad];
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
        
        it(@"keyboardHide", ^{
            [controller keyboardHide];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"textFieldTextChange", ^{
            [controller textFieldTextChange:[UITextField new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"filter", ^{
            NSArray * array = [controller filter:@"job"];
            [[theValue(array) shouldNot] beNil];
        });
        
        it(@"isSearchMode", ^{
            BOOL isSearchMode = [controller isSearchMode];
            [[theValue(isSearchMode) should] equal:theValue(NO)];
        });
        
        
        it(@"scrollViewDidScroll", ^{
            [controller scrollViewDidScroll:[UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        
        it(@"numberOfSectionsInTableView", ^{
            NSInteger num = [controller numberOfSectionsInTableView:[UITableView new]];
            [[theValue(num) should] equal:theValue(1)];
        });
        
        it(@"numberOfRowsInSection", ^{
            NSInteger num = [controller tableView:[UITableView new] numberOfRowsInSection:0];
            [[theValue(num) should] equal:theValue(0)];
        });
        
        it(@"heightForHeaderInSection", ^{
            CGFloat height = [controller tableView:[UITableView new] heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(30)];
        });
        
        it(@"viewForHeaderInSection", ^{
            UIView *view = [controller tableView:[UITableView new] viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });
        
        it(@"heightForRowAtIndexPath", ^{
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            CGFloat height = [controller tableView:[UITableView new] heightForRowAtIndexPath:ip];
            [[theValue(height) should] equal:theValue(56)];
        });
        
        it(@"cellForRowAtIndexPath", ^{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
            [tableView registerClass:[FAQSCategoryTableViewCell class] forCellReuseIdentifier:@"FAQSCategoryTableViewCell"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });
        
        it(@"categoryCell", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller categoryCell:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });
        it(@"faqsFunctionCell", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller faqsFunctionCell:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"didSelectRowAtIndexPath", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [controller tableView:[UITableView new] didSelectRowAtIndexPath:indexPath];
            [[theValue(controller) shouldNot] beNil];
        });
        
    });
});
SPEC_END
