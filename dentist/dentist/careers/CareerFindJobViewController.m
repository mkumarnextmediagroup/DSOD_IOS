//
//  CareerFindJobViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerFindJobViewController.h"
#import "Proto.h"
#import "FindJobsTableViewCell.h"
#import "FindJobsSponsorTableViewCell.h"
#import "DSODetailPage.h"
#import "UIViewController+myextend.h"
#import "DsoToast.h"

@interface CareerFindJobViewController ()<UITableViewDelegate,UITableViewDataSource,JobsTableCellDelegate>
{
    NSMutableArray *infoArr;
    UITableView *myTable;
    UILabel *jobCountTitle;
    BOOL isdownrefresh;
}
@end

@implementation CareerFindJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"JOBS";
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 100;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.tableHeaderView=[self makeHeaderView];
    [myTable registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
    [myTable registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsSponsorTableViewCell class])];
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    [self setupRefresh];
   
    
//    [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array,NSInteger totalCount) {
//        NSLog(@"totalCount=%@;jobarr=%@",@(totalCount),array);
//    }];
//
//    [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
//        NSLog(@"totalCount=%@;jobarr=%@",@(totalCount),array);
//    }];
    
//    [Proto addJobApplication:@"5bfd0b22d6fe1747859ac1eb" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];
    
//    [Proto queryJobBookmarks:0 completed:^(NSArray<JobBookmarkModel *> *array) {
//        NSLog(@"jobarr=%@",array);
//    }];
    
//    [Proto addJobBookmark:@"5bfcff05d6fe1747859ac1e1" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];
//
//    [Proto deleteJobBookmark:@"5bfe877bd6fe175342855843" completed:^(HttpResult *result) {
//        NSLog(@"result=%@",@(result.code));
//    }];

    // Do any additional setup after loading the view.
}

-(void)refreshData
{
    [self showIndicator];
    [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideIndicator];
            [self setJobCountTitle:totalCount];
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

- (void)searchClick
{
    NSLog(@"search btn click");
}

-(void)clickFilter:(UIButton *)sender
{
    NSLog(@"Filter btn click");
}

-(void)setJobCountTitle:(NSInteger)jobcount
{
    if (jobcount>0) {
        NSString *jobcountstr=[NSString stringWithFormat:@"%@Jobs",@(jobcount)];
        NSString *jobstr=[NSString stringWithFormat:@"%@ | 5 New",jobcountstr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:jobstr];
        [str addAttribute:NSForegroundColorAttributeName value:Colors.textMain range:NSMakeRange(0,jobcountstr.length+2)];
        [str addAttribute:NSForegroundColorAttributeName value:Colors.textDisabled range:NSMakeRange(jobcountstr.length+2,jobstr.length - (jobcountstr.length+2))];
        jobCountTitle.attributedText = str;
    }else{
        jobCountTitle.text=@"";
    }
    
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 32);
    panel.backgroundColor=[UIColor clearColor];
    
    jobCountTitle=panel.addLabel;
    jobCountTitle.font=[Fonts semiBold:13];
    [[[[[jobCountTitle.layoutMaker leftParent:20] topParent:0] bottomParent:0] rightParent:40] install];
    
    UIButton *filterButton = [panel addButton];
    [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
    [[[[filterButton.layoutMaker topParent:4] rightParent:-15] sizeEq:24 h:24] install];
    [filterButton onClick:self action:@selector(clickFilter:)];
    return panel;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<=1) {
        FindJobsSponsorTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsSponsorTableViewCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        cell.indexPath=indexPath;
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            if (indexPath.row<=4) {
                cell.isNew=YES;
            }else{
                cell.isNew=NO;
            }
            cell.info=self->infoArr[indexPath.row];
        }
        return cell;
    }else{
        FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        cell.indexPath=indexPath;
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            
            
            if (indexPath.row<=4) {
                cell.isNew=YES;
            }else{
                cell.isNew=NO;
            }
            cell.info=self->infoArr[indexPath.row];
        }
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DSODetailPage *detail = [DSODetailPage new];
//    [self.navigationController pushPage:detail];
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat height = scrollView.frame.size.height;
//    CGFloat contentOffsetY = scrollView.contentOffset.y;
//    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
//    if (bottomOffset <= height-50)
//    {
//        NSLog(@"==================================下啦刷选");
//        if (!isdownrefresh) {
//            isdownrefresh=YES;
//            [self showIndicator];
//            [Proto queryAllJobs:self->infoArr.count completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
//                self->isdownrefresh=NO;
//                foreTask(^{
//                    [self hideIndicator];
//                    [self setJobCountTitle:totalCount];
//                    NSLog(@"%@",array);
//                    if(array && array.count>0){
//                        [self->infoArr addObjectsFromArray:array];
//                    }
//                    [self->myTable reloadData];
//                    
//                });
//            }];
//           
//        }
//        
//    }
//}

-(void)FollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view
{
    NSLog(@"FollowJobAction");
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Following to Job…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        JobModel *model=self->infoArr[indexPath.row];
        NSString *jobid=model.id;
        [Proto addJobBookmark:jobid completed:^(HttpResult *result) {
            NSLog(@"result=%@",@(result.code));
            foreTask(^() {
                [self.navigationController.view hideToast];
                if ([view isKindOfClass:[FindJobsSponsorTableViewCell class]]) {
                    FindJobsSponsorTableViewCell *cell =(FindJobsSponsorTableViewCell *)view;
                    [cell updateFollowStatus:result];
                }else if([view isKindOfClass:[FindJobsTableViewCell class]]){
                    FindJobsTableViewCell *cell =(FindJobsTableViewCell *)view;
                    [cell updateFollowStatus:result];
                }
            });
        }];
    }
    
    
}

-(void)UnFollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view
{
    NSLog(@"UnFollowJobAction");
}


@end
