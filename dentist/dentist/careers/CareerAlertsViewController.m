//
//  CareerAlertsViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerAlertsViewController.h"
#import "Proto.h"
#import "AppDelegate.h"
#import "UIViewController+myextend.h"
#import "UITableView+JRTableViewPlaceHolder.h"
#import "CareerAlertsTableViewCell.h"

@interface CareerAlertsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *infoArr;
    UITableView *myTable;
}
@end

@implementation CareerAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"Alerts";
    self.view.backgroundColor=[UIColor whiteColor];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT] install];
    [myTable registerClass:[CareerAlertsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CareerAlertsTableViewCell class])];
    [self createEmptyNotice];
    [self setupRefresh];

    // Do any additional setup after loading the view.
}

-(void)refreshData
{
    [self showIndicator];
    [Proto queryRemindsByUserId:0 completed:^(NSArray<JobAlertsModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideIndicator];
            NSLog(@"%@",array);
            self->infoArr = [NSMutableArray arrayWithArray:array];
            [self->myTable reloadData];
            
        });
    }];
}

//MARK: 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self->myTable addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}

//MARK: 下拉刷新触发,在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    [self refreshData];
    [refreshControl endRefreshing];
}

- (void)createEmptyNotice
{
    [myTable jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:NO];
        UIView *headerVi = self.view.addView;
        [[[[[headerVi.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
//        [[[headerVi.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT] install];
        headerVi.backgroundColor = [UIColor clearColor];
        UIButton *headBtn = headerVi.addButton;
        [headBtn setImage:[UIImage imageNamed:@"noun_mobile notification"] forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[headBtn.layoutMaker centerXParent:0] centerYParent:-60] install];
        UILabel *tipLabel= headerVi.addLabel;
        tipLabel.textAlignment=NSTextAlignmentCenter;
        tipLabel.numberOfLines=0;
        tipLabel.font = [Fonts semiBold:16];
        tipLabel.textColor =[UIColor blackColor];
        tipLabel.text=@"Add your first Job \n \n Receive a daily email with the best matched \njobs from DSOs";
        [[[[tipLabel.layoutMaker leftParent:20] rightParent:-20] below:headBtn offset:30] install];
//        UIView *createview=headerVi.addView;
//        createview.backgroundColor=Colors.textDisabled;
//        [[[[[createview.layoutMaker leftParent:20] rightParent:-20] below:tipLabel offset:30]  heightEq:44] install];
        return headerVi;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:YES];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CareerAlertsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CareerAlertsTableViewCell class]) forIndexPath:indexPath];
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        JobAlertsModel *model=self->infoArr[indexPath.row];
        cell.alerModel=model;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
