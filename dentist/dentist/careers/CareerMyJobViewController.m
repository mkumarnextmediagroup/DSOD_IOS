//
//  CareerMyJobViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerMyJobViewController.h"
#import "Proto.h"
#import "FindJobsTableViewCell.h"
#import "FindJobsSponsorTableViewCell.h"
#import "DSODetailPage.h"
#import "UIViewController+myextend.h"
#import "DentistTabView.h"
#import "JobApplyModel.h"
#import "JobBookmarkModel.h"
#import "DsoToast.h"
#import "CareerSearchViewController.h"
#import "AppDelegate.h"
#import "JobDetailViewController.h"

@interface CareerMyJobViewController ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate,JobsTableCellDelegate>
{
    NSArray *infoArr;
    UITableView *myTable;
    UILabel *jobCountTitle;
    DentistTabView *tabView;
    NSInteger selectIndex;
    NSMutableArray *applyArr;
    NSMutableArray *followArr;
    BOOL isdownrefresh;
}
@end

@implementation CareerMyJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"MY JOBS";
//    self.view.backgroundColor=[UIColor whiteColor];

    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 100;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.tableHeaderView=[self makeHeaderView];
    [myTable registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:@"myjobcell"];

    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT] install];
    [self setupRefresh];

    
    // Do any additional setup after loading the view.
}
- (void)backToFirst
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabvc=(UITabBarController *)appdelegate.careersPage;
    [tabvc setSelectedIndex:0];
}

-(void)refreshData
{
    if(selectIndex==0){
        [self->myTable reloadData];
        [self showIndicator];
        [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
            foreTask(^{
                [self hideIndicator];
                [self setJobCountTitle:totalCount];
                NSLog(@"%@",array);
                self->applyArr = [NSMutableArray arrayWithArray:array];
                [self->myTable reloadData];
                
            });
        }];
    }else{
        [self->myTable reloadData];
        [self showIndicator];
        [Proto queryJobBookmarks:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
            foreTask(^{
                [self hideIndicator];
                [self setJobCountTitle:totalCount];
                NSLog(@"%@",array);
                self->followArr = [NSMutableArray arrayWithArray:array];
                [self->myTable reloadData];
                
            });
        }];
    }
}


//MARK: 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self->myTable addSubview:refreshControl];
//    [refreshControl beginRefreshing];
//    [self refreshClick:refreshControl];
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
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CareerSearchViewController *searchVC=[CareerSearchViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:navVC animated:NO completion:NULL];
}

-(void)clickFilter:(UIButton *)sender
{
    NSLog(@"Filter btn click");
}

-(void)setJobCountTitle:(NSInteger)jobcount
{
    if (jobcount>0) {
        NSString *jobcountstr=[NSString stringWithFormat:@"%@Jobs",@(jobcount)];
//        NSString *jobstr=[NSString stringWithFormat:@"%@ | 5 New",jobcountstr];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:jobstr];
//        [str addAttribute:NSForegroundColorAttributeName value:Colors.textMain range:NSMakeRange(0,jobcountstr.length+2)];
//        [str addAttribute:NSForegroundColorAttributeName value:Colors.textDisabled range:NSMakeRange(jobcountstr.length+2,jobstr.length - (jobcountstr.length+2))];
//        jobCountTitle.attributedText = str;
        jobCountTitle.text=jobcountstr;
    }else{
        jobCountTitle.text=@"";
    }
    
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 91);
    panel.backgroundColor=[UIColor clearColor];
    
    tabView=[DentistTabView new];
    tabView.isScrollEnable=NO;
    tabView.itemCount=2;
    tabView.delegate=self;
    [panel addSubview:tabView];
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:51] install];
    tabView.titleArr=[NSMutableArray arrayWithArray:@[@"APPLED",@"SAVE"]];
    
    jobCountTitle=panel.addLabel;
    jobCountTitle.font=[Fonts semiBold:13];
    jobCountTitle.textColor=Colors.textMain;
    [[[[[jobCountTitle.layoutMaker leftParent:20] below:tabView offset:0] bottomParent:0] rightParent:40] install];
    
//    UIButton *filterButton = [panel addButton];
//    [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
//    [[[[filterButton.layoutMaker below:tabView offset:8] rightParent:-15] sizeEq:24 h:24] install];
//    [filterButton onClick:self action:@selector(clickFilter:)];
    UILabel *lineLabel=panel.lineLabel;
    [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    return panel;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectIndex==0) {
        return applyArr.count;
    }else{
        return followArr.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindJobsSponsorTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myjobcell" forIndexPath:indexPath];
    cell.delegate=self;
    cell.indexPath=indexPath;
    if (selectIndex==0) {
        if (self->applyArr && self->applyArr.count>indexPath.row) {
            JobApplyModel *applymodel=(JobApplyModel *)self->applyArr[indexPath.row];
            cell.isHideNew=YES;
            cell.info=applymodel.jobPO;
            
        }
    }else{
        if (self->followArr && self->followArr.count>indexPath.row) {
            JobBookmarkModel *bookmarkmodel=(JobBookmarkModel *)self->followArr[indexPath.row];
            cell.isHideNew=YES;
            cell.follow=YES;
            cell.followid=bookmarkmodel.id;
            cell.info=bookmarkmodel.jobPO;
        }
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *jobid;
    if (selectIndex==0) {
        if (self->applyArr && self->applyArr.count>indexPath.row) {
            JobApplyModel *applymodel=(JobApplyModel *)self->applyArr[indexPath.row];
            jobid=applymodel.jobId;
        }
    }else{
        if (self->followArr && self->followArr.count>indexPath.row) {
            JobBookmarkModel *bookmarkmodel=(JobBookmarkModel *)self->followArr[indexPath.row];
            jobid=bookmarkmodel.jobId;
        }
    }
    if (jobid) {
        [JobDetailViewController presentBy:nil jobId:jobid closeBack:^{
            foreTask(^{
                if (self->myTable) {
                    [self->myTable reloadData];
                }
            });
            
        }];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat consizeheight=scrollView.contentSize.height;
    CGFloat bottomOffset = (consizeheight - contentOffsetY);
    if (bottomOffset <= height-50 && contentOffsetY>0)
    {
        NSLog(@"==================================下啦刷选;bottomOffset=%@;height-50=%@",@(bottomOffset),@(height-50));
        if (!isdownrefresh) {
            isdownrefresh=YES;
            if(selectIndex==0){
                [self showIndicator];
                [Proto queryAllApplicationJobs:self->applyArr.count completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
                    foreTask(^{
                        [self hideIndicator];
                        [self setJobCountTitle:totalCount];
                        if(array && array.count>0){
                            [self->applyArr addObjectsFromArray:array];
                            [self->myTable reloadData];
                        }
                        
                        
                    });
                }];
            }else{
                [self showIndicator];
                [Proto queryJobBookmarks:self->followArr.count completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
                    foreTask(^{
                        [self hideIndicator];
                        [self setJobCountTitle:totalCount];
                        if(array && array.count>0){
                            [self->followArr addObjectsFromArray:array];
                            [self->myTable reloadData];
                        }
                        
                        
                    });
                }];
            }
            
        }
        
    }
}

#pragma mark -------DentistTabViewDelegate
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"selectindex=%@",@(index));
    selectIndex=index;
    [self refreshData];
}


-(void)FollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view
{
    NSLog(@"FollowJobAction");
    NSString *jobid;
    if (selectIndex==0) {
        if (self->applyArr && self->applyArr.count>indexPath.row) {
            JobApplyModel *applymodel=(JobApplyModel *)self->applyArr[indexPath.row];
            jobid=applymodel.jobId;
        }
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Following to Job…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
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
    NSString *followid;
    if (selectIndex==1) {
        if (self->followArr && self->followArr.count>indexPath.row) {
            JobBookmarkModel *followmodel=(JobBookmarkModel *)self->followArr[indexPath.row];
            followid=followmodel.id;
            UIView *dsontoastview=[DsoToast toastViewForMessage:@"UNFollowing from Job……" ishowActivity:YES];
            [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
            [Proto deleteJobBookmark:followid completed:^(HttpResult *result) {
                NSLog(@"result=%@",@(result.code));
                foreTask(^() {
                    [self.navigationController.view hideToast];
                    [self->followArr removeObjectAtIndex:indexPath.row];
                    [self->myTable reloadData];
                });
            }];
        }
    }
}

@end
