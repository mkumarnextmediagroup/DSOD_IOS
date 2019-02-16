//
//  ContactUsViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ContactUsViewController.h"

SPEC_BEGIN(ContactUsViewControllerTests)
describe(@"Unit Test For ContactUsViewController", ^{
    __block ContactUsViewController *controller;
    
    beforeEach(^{
        controller = [ContactUsViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [ContactUsViewController openBy:[UIViewController new]];
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
        
        it(@"dismiss", ^{
            [controller dismiss];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"submitBtnClick", ^{
            [controller submitBtnClick];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"uploadAttach", ^{
            [controller uploadAttach:[UIImage new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"addFeedback", ^{
            [controller addFeedback];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"showPhoto", ^{
            [controller showPhoto:[UIImage new] name:@"image"];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"delAttachment", ^{
            [controller delAttachment];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"addAttachMent", ^{
            [controller addAttachMent];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"saveImageDocuments", ^{
            [controller saveImageDocuments:[UIImage new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"textViewShouldBeginEditing", ^{
            [controller textViewShouldBeginEditing:[UITextView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"textViewDidEndEditing", ^{
            [controller textViewDidEndEditing:[UITextView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"text", ^{
            UITextView *textview = [UITextView new];
            textview.text = @"text";
            textview.tag = 1;
            NSString *text = [controller text:textview];
            [[text should] equal:@"text"];
        });
        
        it(@"textViewDidEndEditing", ^{
            BOOL result = [controller textView:[UITextView new] shouldChangeTextInRange:NSMakeRange(0, 0)
                               replacementText:@"text"];
            [[theValue(result) should] equal:theValue(YES)];
        });
        
    });
});
SPEC_END
