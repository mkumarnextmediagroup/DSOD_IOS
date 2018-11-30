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

@interface CareerMyJobViewController ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate>
{
    NSArray *infoArr;
    UITableView *myTable;
    UILabel *jobCountTitle;
    DentistTabView *tabView;
    NSInteger selectIndex;
    NSArray *applyArr;
    NSArray *followArr;
}
@end

@implementation CareerMyJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"MY JOBS";
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 100;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.tableHeaderView=[self makeHeaderView];
    [myTable registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:@"myjobcell"];
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    [self showIndicator];
    [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideIndicator];
            [self setJobCountTitle:totalCount];
            NSLog(@"%@",array);
            self->infoArr = array;
            [self->myTable reloadData];
            
        });
    }];
    
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
    [[[[[jobCountTitle.layoutMaker leftParent:20] below:tabView offset:0] bottomParent:0] rightParent:40] install];
    
    UIButton *filterButton = [panel addButton];
    [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
    [[[[filterButton.layoutMaker below:tabView offset:8] rightParent:-15] sizeEq:24 h:24] install];
    [filterButton onClick:self action:@selector(clickFilter:)];
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
    if (selectIndex==0) {
        if (self->applyArr && self->applyArr.count>indexPath.row) {
            JobApplyModel *applymodel=(JobApplyModel *)self->applyArr[indexPath.row];
            cell.info=applymodel.jobPO;
        }
    }else{
        if (self->followArr && self->followArr.count>indexPath.row) {
            JobBookmarkModel *bookmarkmodel=(JobBookmarkModel *)self->followArr[indexPath.row];
            cell.info=bookmarkmodel.jobPO;
        }
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSODetailPage *detail = [DSODetailPage new];
    [self.navigationController pushPage:detail];
}

#pragma mark -------DentistTabViewDelegate
-(void)didDentistSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"selectindex=%@",@(index));
    selectIndex=index;
    if(selectIndex==0){
        [self->myTable reloadData];
        [self showIndicator];
        [Proto queryAllApplicationJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
            foreTask(^{
                [self hideIndicator];
                [self setJobCountTitle:totalCount];
                NSLog(@"%@",array);
                self->applyArr = array;
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
                self->followArr = array;
                [self->myTable reloadData];
                
            });
        }];
    }
}

@end
