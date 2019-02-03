//
//  PlaybackSpeedViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "PlaybackSpeedViewController.h"
#import "Common.h"
#import "SettingLabelAndCheckedTableViewCell.h"
#import "Proto.h"

@interface PlaybackSpeedViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PlaybackSpeedViewController{
    
    //table view
    UITableView *tableView;
    //Data source array
    NSArray<NSDictionary*>* dataArray;
}


/**
 get playback speed data source array
 @return data source array
 */
+(NSArray<NSDictionary*>*)playbackSpeedArray{
    return @[
             @{@"text":@"0.5x" },
             @{@"text":@"0.75x" },
             @{@"text":@"1.0x" },
             @{@"text":@"1.25x" },
             @{@"text":@"1.5x"},
             @{@"text":@"2.0x" }
             ];
}


/**
 get selected playback speedy text
 @return playback speed text
 */
+(NSString*)getCheckedPlaybackSpeedText{
    NSString *text = [[NSUserDefaults standardUserDefaults] objectForKey:@"playbackSpeed"];
    return [NSString isBlankString:text] ? @"1.0x" : text;
}


/**
 Save the selected playback speedy locally
 */
+(void)saveCheckedPlaybackSpeedText:(NSString*)text{
    [[NSUserDefaults standardUserDefaults] setObject:text forKey:@"playbackSpeed"];
}

/**
 Open setting playback speed page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc {
    PlaybackSpeedViewController *newVc = [PlaybackSpeedViewController new];
    [vc pushPage:newVc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self buildViews];
    
    dataArray = [PlaybackSpeedViewController playbackSpeedArray];
    [tableView reloadData];
}


/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"PLAYBACK SPEED";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}


/**
 build views
 */
-(void)buildViews{
    self.view.backgroundColor = UIColor.whiteColor;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 1000;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:SettingLabelAndCheckedTableViewCell.class forCellReuseIdentifier:NSStringFromClass(SettingLabelAndCheckedTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
}


#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 number of rows in section
 
 @param tableView UITableView
 @param section section index
 @return number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


/**
 UITableViewDataSource
 cell for row at index path
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingLabelAndCheckedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SettingLabelAndCheckedTableViewCell.class)];
    
    NSString *text = dataArray[indexPath.row][@"text"];
    [cell setText:text isChecked:[text isEqualToString:[PlaybackSpeedViewController getCheckedPlaybackSpeedText]]];
    
    return cell;
}

/**
 UITableViewDelegate
 did select row at indexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self showLoading];
    [Proto addGeneralsettingsVideoDownloadQuality:dataArray[indexPath.row][@"text"] completed:^(HttpResult *result) {
        [self hideLoading];
        if (result.OK) {
             [PlaybackSpeedViewController saveCheckedPlaybackSpeedText:self->dataArray[indexPath.row][@"text"]];
            [tableView reloadData];
            [self dismiss];
        }
    }];
   
    
}
@end
