//
//  PlaybackSpeedViewControllerTests.m
//  dentistTests
//
//  Created by Shirley on 2019/2/2.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "PlaybackSpeedViewController.h"
#import "SettingLabelAndCheckedTableViewCell.h"

SPEC_BEGIN(PlaybackSpeedViewControllerTests)
describe(@"Unit Test For PlaybackSpeedViewController", ^{
    __block PlaybackSpeedViewController *controller;
    
    beforeEach(^{
        controller = [PlaybackSpeedViewController new];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    context(@"methods", ^{
        it(@"openBy", ^{
            [PlaybackSpeedViewController openBy:[UIViewController new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
        
        it(@"playbackSpeedArray", ^{
            NSArray<NSDictionary*>* arryay = [PlaybackSpeedViewController playbackSpeedArray];
            [[theValue(arryay) shouldNot] beNil];
        });
        
        it(@"getCheckedPlaybackSpeedText", ^{
            NSString *text = [PlaybackSpeedViewController getCheckedPlaybackSpeedText];
            [[text shouldNot] beNil];
        });
        
        it(@"saveCheckedPlaybackSpeedText", ^{
            [PlaybackSpeedViewController saveCheckedPlaybackSpeedText:@"0.5x"];
            NSString *text = [PlaybackSpeedViewController getCheckedPlaybackSpeedText];
            [[text should] equal:@"0.5x" ];
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
