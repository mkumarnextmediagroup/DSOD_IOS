//
//  CompanyDetailJobsViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyDetailJobsViewController.h"
#import "common.h"
#import "FindJobsTableViewCell.h"
#import "Proto.h"
#import "UIView+Toast.h"

@interface CompanyDetailJobsViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation CompanyDetailJobsViewController{
    
    int edge;
    
    UITableView *tableView;
    UIView *sectionHeaderView;
    UIView *filterView;
    UILabel *jobCountTitle;
    
    NSArray<JobModel*> *jobArray;
    
    BOOL isRefreshing;
}



- (void)viewDidLoad{
    edge = 18;
    [self buildView];
    
    [Proto getAllJobsByCompanyId:self.companyId skip:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideLoading];
//            [self setJobCountTitle:3];
//            self->jobArray =  @[[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new]];
            [self setJobCountTitle:totalCount];
            self->jobArray = array;
            [self->tableView reloadData];
        });
    }];
}


-(void)buildView{
    edge = 18;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    [tableView registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
   
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(!sectionHeaderView){
        sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 32)];
        
        
        
        filterView = sectionHeaderView.addView;
        [[[[[filterView.layoutMaker leftParent:0] rightParent:0] topParent:0]heightEq:32]  install];
        filterView.backgroundColor=[UIColor whiteColor];
        
        jobCountTitle=filterView.addLabel;
        jobCountTitle.textColor =Colors.textMain;
        jobCountTitle.font=[Fonts semiBold:13];
        [[[[[jobCountTitle.layoutMaker leftParent:20] topParent:0] bottomParent:0] rightParent:40] install];
        
        
        UILabel *lineLabel=filterView.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    return sectionHeaderView;
}

-(void)setJobCountTitle:(NSInteger)jobcount
{
    if (jobcount>0) {
        NSString *jobcountstr=[NSString stringWithFormat:@"%@Jobs",@(jobcount)];
        //        NSString *jobstr=[NSString stringWithFormat:@"%@ | 5 New",jobcountstr];
        //        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:jobstr];
        //        [str addAttribute:NSForegroundColorAttributeName value:Colors.textMain range:NSMakeRange(0,jobcountstr.length+2)];
        //        [str addAttribute:NSForegroundColorAttributeName value:Colors.textDisabled range:NSMakeRange(jobcountstr.length+2,jobstr.length - (jobcountstr.length+2))];
        jobCountTitle.text = jobcountstr;
    }else{
        jobCountTitle.text=@"";
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return jobArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
    //    cell.delegate=self;
    cell.indexPath=indexPath;
    if (jobArray && jobArray.count>indexPath.row) {
        cell.info=jobArray[indexPath.row];
    }
    return cell;
    
}


#pragma mark - 滑动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    /// 当偏移量小于0时，不能滑动，并且使主要视图的UITableView滑动
    if (scrollView.contentOffset.y < 0 ) {
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        if (self.noScrollAction) {
            self.noScrollAction();
        }
    }
    
    if(!isRefreshing
       && scrollView.contentSize.height > scrollView.frame.size.height
       && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)) ){
//        [self getDatas:YES];
        [self.parentViewController.view makeToast:@"加载更多"];
        
        
    }
}

-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}
@end
