//
//  VideoQualityViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/5.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "VideoQualityViewController.h"
#import "Common.h"
#import "SettingLabelAndCheckedTableViewCell.h"
#import "Proto.h"

@interface VideoQualityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end


@implementation VideoQualityViewController{
    
    UITableView *tableView;
    
    NSArray<NSDictionary*>* dataArray;
}

+(NSArray<NSDictionary*>*)videoQualityArray{
    return @[
             @{@"text":@"144p" },
             @{@"text":@"360p" },
             @{@"text":@"480p" },
             @{@"text":@"720p" },
             @{@"text":@"1080p"},
             @{@"text":@"Auto" }
             ];
}

+(NSString*)getCheckedVideoQualityText{
    NSString *text = [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoQuality"];
    return [NSString isBlankString:text] ? @"Auto" : text;
}

+(void)saveCheckedVideoQualityText:(NSString*)text{
    [[NSUserDefaults standardUserDefaults] setObject:text forKey:@"VideoQuality"];
}


+(void)openBy:(UIViewController*)vc {
    VideoQualityViewController *newVc = [VideoQualityViewController new];
    [vc pushPage:newVc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self buildViews];
    
    dataArray = [VideoQualityViewController videoQualityArray];
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
    [cell setText:text isChecked:[text isEqualToString:[VideoQualityViewController getCheckedVideoQualityText]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self showLoading];
    [Proto addGeneralsettingsVideoDownloadQuality:dataArray[indexPath.row][@"text"] completed:^(HttpResult *result) {
        [self hideLoading];
        if (result.OK) {
            [VideoQualityViewController saveCheckedVideoQualityText:self->dataArray[indexPath.row][@"text"]];
            [tableView reloadData];
        }
    }];
    
    
}
@end
