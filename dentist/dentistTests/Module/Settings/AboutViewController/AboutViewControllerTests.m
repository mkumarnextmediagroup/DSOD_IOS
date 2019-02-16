//
//  AboutViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "AboutViewController.h"

SPEC_BEGIN(AboutViewControllerTests)
describe(@"Unit Test For AboutViewController", ^{
    __block AboutViewController *controller;
    
    beforeEach(^{
        controller = [AboutViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [AboutViewController openBy:[UIViewController new]];
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
        
        it(@"didDentistSelectItemAtIndex", ^{
            [controller didDentistSelectItemAtIndex:0];
            [[theValue(controller.view) shouldNot] beNil];
            [controller didDentistSelectItemAtIndex:1];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
    });
});
SPEC_END
