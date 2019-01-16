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
    UITableView *tableView;
    
    NSArray<NSDictionary*>* dataArray;
}

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

+(NSString*)getCheckedPlaybackSpeedText{
    NSString *text = [[NSUserDefaults standardUserDefaults] objectForKey:@"playbackSpeed"];
    return [NSString isBlankString:text] ? @"1.0x" : text;
}

+(void)saveCheckedPlaybackSpeedText:(NSString*)text{
    [[NSUserDefaults standardUserDefaults] setObject:text forKey:@"playbackSpeed"];
}


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

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"VIDEO QUALITY";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingLabelAndCheckedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SettingLabelAndCheckedTableViewCell.class)];
    
    NSString *text = dataArray[indexPath.row][@"text"];
    [cell setText:text isChecked:[text isEqualToString:[PlaybackSpeedViewController getCheckedPlaybackSpeedText]]];
    
    return cell;
}

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
