//
//  VideoQualityViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "VideoQualityViewController.h"
#import "SettingLabelAndCheckedTableViewCell.h"

SPEC_BEGIN(VideoQualityViewControllerTests)
describe(@"Unit Test For VideoQualityViewController", ^{
    __block VideoQualityViewController *controller;
    
    beforeEach(^{
        controller = [VideoQualityViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [VideoQualityViewController openBy:[UIViewController new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"videoQualityArray", ^{
            NSArray<NSDictionary*>* arryay = [VideoQualityViewController videoQualityArray];
            [[theValue(arryay) shouldNot] beNil];
        });
        
        it(@"getCheckedVideoQualityText", ^{
            NSString *text = [VideoQualityViewController getCheckedVideoQualityText];
            [[text shouldNot] beNil];
        });
        
        it(@"saveCheckedVideoQualityText", ^{
            [VideoQualityViewController saveCheckedVideoQualityText:@"1080p"];
            NSString *text = [VideoQualityViewController getCheckedVideoQualityText];
            [[text should] equal:@"1080p" ];
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
            [tableView registerClass:[SettingLabelAndCheckedTableViewCell class] forCellReuseIdentifier:@"SettingLabelAndCheckedTableViewCell"];
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
