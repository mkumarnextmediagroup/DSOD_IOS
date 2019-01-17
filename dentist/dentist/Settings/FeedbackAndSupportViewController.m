//
//  FeedbackAndSupportViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/10.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "FeedbackAndSupportViewController.h"
#import "Common.h"
#import "SettingTableViewCell.h"
#import "HelpAndFeedbackViewController.h"
#import "ContactUsViewController.h"

@interface FeedbackAndSupportViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FeedbackAndSupportViewController{
    
    UITableView *tableView;
    NSArray *dataArray;
}


+(void)openBy:(UIViewController*)vc{
    FeedbackAndSupportViewController *newVc = [FeedbackAndSupportViewController new];
    [vc pushPage:newVc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = @[@"Rate in the App Store",@"Help and Feedback",@"Contact DSODentist"];
    
    [self addNavBar];
    
    [self buildViews];
}


-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"FeeFdback and support";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

-(void)buildViews{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight=55;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] bottomParent:0] install];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    cell.textLabel.textColor = UIColor.blackColor;
    cell.textLabel.font = [Fonts regular:15];
    cell.textLabel.text = dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *lineLabel = [cell lineLabel];
    lineLabel.frame = CGRectMake(0, 54, SCREENWIDTH, 1);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/twitter/id%@?mt=8",DENTISTAPPID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            break;
        }
        case 1:
            [HelpAndFeedbackViewController openBy:self];
            break;
        case 2:
            [ContactUsViewController openBy:self];
            break;
    }
}

@end
