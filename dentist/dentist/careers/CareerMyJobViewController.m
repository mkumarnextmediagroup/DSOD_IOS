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
#import "UIViewController+myextend.h"
#import "DentistTabView.h"
#import "JobApplyModel.h"
#import "JobBookmarkModel.h"
#import "DsoToast.h"
#import "CareerSearchViewController.h"
#import "AppDelegate.h"
#import "JobDetailViewController.h"
#import "UITableView+JRTableViewPlaceHolder.h"
#import "JobsBookmarkManager.h"

@interface CareerMyJobViewController ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate,JobsTableCellDelegate>
{
    NSArray *infoArr;
    UITableView *myTable;
    UILabel *jobCountTitle;
    DentistTabView *tabView;
    NSMutableArray *applyArr;
    NSMutableArray *followArr;
    NSInteger applyCount;
    NSInteger followCount;
    BOOL isdownrefresh;
}
@end

@implementation CareerMyJobViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __block BOOL updatedata=NO;
    __block NSInteger updatecount=0;
    if(_selectIndex==1){
        if (self->followArr && self->followArr.count>0) {
            [self->followArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass: [JobBookmarkModel class]]) {
                    JobBookmarkModel *model=(JobBookmarkModel *)obj;
                    if ([[JobsBookmarkManager shareManager] checkIsDeleteBookmark:getLastAccount() postid:model.jobId]) {
                        
                        // 更新数据源
                        if (self->followArr.count>idx) {
                            self->followCount--;
                            if (self->followCount<=0) {
                                self->followCount=0;
                            }
                            [self->followArr removeObjectAtIndex:idx];
                        }
                    }
                    
                }
            }];
            [self setJobCountTitle:self->followCount];
            NSMutableArray *temparr=[[JobsBookmarkManager shareManager] addArr];
            [temparr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                __block NSString *jobid=[[JobsBookmarkManager shareManager] getPostid:getLastAccount() keyvalue:obj];
                [self->followArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass: [JobBookmarkModel class]]) {
                        JobBookmarkModel *model=(JobBookmarkModel *)obj;
                        if ([model.jobId isEqualToString:jobid]) {
                            updatecount++;
                        }
                    }
                }];
            }];
        }
        if ([[[JobsBookmarkManager shareManager] addArr] count] != updatecount) {
            updatedata=YES;
        }
        
    }else if (_selectIndex==0){
        if (self->applyArr && self->applyArr.count>0) {
            NSMutableArray *temparr=[[JobsBookmarkManager shareManager] applyArr];
            [temparr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                __block NSString *jobid=[[JobsBookmarkManager shareManager] getPostid:getLastAccount() keyvalue:obj];
                [self->applyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass: [JobApplyModel class]]) {
                        JobApplyModel *model=(JobApplyModel *)obj;
                        if ([model.jobId isEqualToString:jobid]) {
                            updatecount++;
                        }
                    }
                }];
            }];
        }
        if ([[[JobsBookmarkManager shareManager] applyArr] count] != updatecount) {
            updatedata=YES;
        }
    }
    if (updatedata) {
        [self refreshData];
    }else{
        if (myTable) {
            [myTable reloadData];
        }
    }
}

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
    [self createEmptyNotice];
    [self setupRefresh];
    
    // Do any additional setup after loading the view.
}

- (void)createEmptyNotice
{
    [myTable jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:NO];
        UIView *headerVi = [UIView new];
        [sender addSubview:headerVi];
        [[[headerVi.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT-91] topParent:91] install];
        headerVi.backgroundColor = [UIColor clearColor];
        UIButton *headBtn = headerVi.addButton;
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[headBtn.layoutMaker centerXParent:0] centerYParent:-80] install];
        UILabel *tipLabel= headerVi.addLabel;
        tipLabel.textAlignment=NSTextAlignmentCenter;
        tipLabel.numberOfLines=0;
        tipLabel.font = [Fonts semiBold:16];
        tipLabel.textColor =[UIColor blackColor];
        [[[[tipLabel.layoutMaker leftParent:20] rightParent:-20] below:headBtn offset:50] install];
        if (self->_selectIndex==0) {
            [headBtn setImage:[UIImage imageNamed:@"noun_receipt"] forState:UIControlStateNormal];
            tipLabel.text=@"You have not yet applied for a job through\nDSODentis";
        }else{
            [headBtn setImage:[UIImage imageNamed:@"noun_Briefcase"] forState:UIControlStateNormal];
            tipLabel.text=@"You have not saved jobs yet.\nSave jobs to view later from this\nscreen";
        }
        return headerVi;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:YES];
    }];
}
- (void)backToFirst
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabvc=(UITabBarController *)appdelegate.careersPage;
    [tabvc setSelectedIndex:0];
}

-(void)tableReloadData
{
    [self createEmptyNotice];
    [self->myTable reloadData];
}

-(void)refreshData
{
    if(_selectIndex==0){
        [self setJobCountTitle:self->applyCount];
        [self->myTable reloadData];
        [self showIndicator];
        [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
            foreTask(^{
                self->applyCount=totalCount;
                [self hideIndicator];
                [self setJobCountTitle:self->applyCount];
                NSLog(@"%@",array);
                self->applyArr = [NSMutableArray arrayWithArray:array];
                [self->myTable reloadData];
                
            });
        }];
    }else{
        [self setJobCountTitle:self->followCount];
        [self->myTable reloadData];
        [self showIndicator];
        [Proto queryJobBookmarks:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
            foreTask(^{
                self->followCount=totalCount;
                [self hideIndicator];
                [self setJobCountTitle:self->followCount];
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
    tabView.titleArr=[NSMutableArray arrayWithArray:@[@"APPLED",@"SAVED"]];
    
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
    if (_selectIndex==0) {
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
    if (_selectIndex==0) {
        if (self->applyArr && self->applyArr.count>indexPath.row) {
            JobApplyModel *applymodel=(JobApplyModel *)self->applyArr[indexPath.row];
            cell.isHideNew=YES;
            cell.isApply=YES;
            cell.info=applymodel.jobPO;
            
        }
    }else{
        if (self->followArr && self->followArr.count>indexPath.row) {
            JobBookmarkModel *bookmarkmodel=(JobBookmarkModel *)self->followArr[indexPath.row];
            cell.isApply=NO;
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
    if (_selectIndex==0) {
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
        BOOL isshowapplybtn=NO;
        if (_selectIndex==0) {
            isshowapplybtn=YES;
        }
        [JobDetailViewController presentBy:nil jobId:jobid isShowApply:isshowapplybtn closeBack:^(NSString * jobid,NSString *unFollowjobid) {
            foreTask(^{
                if (self->_selectIndex==1 && ![NSString isBlankString:unFollowjobid]) {
                    [self->followArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass: [JobBookmarkModel class]]) {
                            JobBookmarkModel *model=(JobBookmarkModel *)obj;
                            if ([model.jobId isEqualToString:unFollowjobid]) {
                                // 更新数据源
                                if (self->followArr.count>idx) {
                                    self->followCount--;
                                    if (self->followCount<=0) {
                                        self->followCount=0;
                                    }
                                    [self->followArr removeObjectAtIndex:idx];
                                }
                                *stop = YES;
                            }
                        }
                    }];
                    [self setJobCountTitle:self->followCount];
                }
                
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
            if(_selectIndex==0){
                [self showIndicator];
                [Proto queryAllApplicationJobs:self->applyArr.count completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
                    foreTask(^{
                        self->applyCount=totalCount;
                        [self hideIndicator];
                        [self setJobCountTitle:self->applyCount];
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
                        self->followCount=totalCount;
                        [self hideIndicator];
                        [self setJobCountTitle:self->followCount];
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
    _selectIndex=index;
    [self refreshData];
}


-(void)FollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view
{
    NSLog(@"FollowJobAction");
    NSString *jobid;
    if (_selectIndex==0) {
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
                if (result.OK) {
                    if ([view isKindOfClass:[FindJobsSponsorTableViewCell class]]) {
                        FindJobsSponsorTableViewCell *cell =(FindJobsSponsorTableViewCell *)view;
                        [cell updateFollowStatus:YES];
                    }else if([view isKindOfClass:[FindJobsTableViewCell class]]){
                        FindJobsTableViewCell *cell =(FindJobsTableViewCell *)view;
                        [cell updateFollowStatus:YES];
                    }
                }
                
            });
        }];
    }
}

-(void)UnFollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view
{
    NSLog(@"UnFollowJobAction");
    NSString *followid;
    if (_selectIndex==1) {
        if (self->followArr && self->followArr.count>indexPath.row) {
            JobBookmarkModel *followmodel=(JobBookmarkModel *)self->followArr[indexPath.row];
            followid=followmodel.jobId;
            UIView *dsontoastview=[DsoToast toastViewForMessage:@"UNFollowing from Job……" ishowActivity:YES];
            [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
            [Proto deleteJobBookmarkByJobId:followid completed:^(HttpResult *result) {
                NSLog(@"result=%@",@(result.code));
                foreTask(^() {
                    if(result.OK){
                        [self.navigationController.view hideToast];
                        self->followCount--;
                        if (self->followCount<=0) {
                            self->followCount=0;
                        }
                        [self setJobCountTitle:self->followCount];
                        [self->followArr removeObjectAtIndex:indexPath.row];
                        [self->myTable reloadData];
                    }else{
                        NSString *message=result.msg;
                        if([NSString isBlankString:message]){
                            message=@"Failed";
                        }
                        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                        [window makeToast:message
                                 duration:1.0
                                 position:CSToastPositionBottom];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                });
            }];
        }
    }
}

@end
