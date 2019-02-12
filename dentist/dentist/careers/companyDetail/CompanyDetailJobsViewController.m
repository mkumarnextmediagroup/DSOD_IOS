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
#import "JobDetailViewController.h"
#import "UITableView+JRTableViewPlaceHolder.h"

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
    BOOL isfirstfresh;
}



/**
 view did load
 call buildview function
 */
- (void)viewDidLoad{
    edge = 18;
    [self buildView];
}

/**
 set dso id
 get all jobs of dso

 @param companyId dso id
 */
-(void)setCompanyId:(NSString *)companyId
{
    _companyId=companyId;
//    [self showLoading];
    [Proto getAllJobsByCompanyId:self.companyId skip:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            self->isfirstfresh=YES;
            [self hideLoading];
            //            [self setJobCountTitle:3];
            //            self->jobArray =  @[[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new],[JobModel new]];
            [self setJobCountTitle:totalCount];
            self->jobArray = array;
            [self->tableView reloadData];
        });
    }];
}


/**
 build views
 */
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
    [self createEmptyNotice];
   
}

/**
 初始化没有数据时的默认布局
 Initialize the default layout when there is no data
 */
- (void)createEmptyNotice
{
    [tableView jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        UIView *headerVi = [UIView new];
        headerVi.backgroundColor = [UIColor clearColor];
        if (self->isfirstfresh) {
            UIButton *headBtn = headerVi.addButton;
            [headBtn setImage:[UIImage imageNamed:@"career_searchIcon"] forState:UIControlStateNormal];
            headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            headBtn.titleLabel.font = [Fonts regular:13];
            [[[[headBtn.layoutMaker centerXParent:0] topParent:80] sizeEq:80 h:80] install];
            UILabel *tipLabel= headerVi.addLabel;
            tipLabel.textAlignment=NSTextAlignmentCenter;
            tipLabel.numberOfLines=0;
            tipLabel.font = [Fonts semiBold:15];
            tipLabel.textColor =[UIColor blackColor];
            tipLabel.text=@"Sorry, we didn't find any Jobs";
            [[[[tipLabel.layoutMaker leftParent:20] rightParent:-20] below:headBtn offset:30] install];
        }
        
        return headerVi;
        
    } normalBlock:^(UITableView * _Nonnull sender) {
    }];
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

/**
 设置标题，显示职位数量
 Set the title to show the number of jobs

 @param jobcount <#jobcount description#>
 */
-(void)setJobCountTitle:(NSInteger)jobcount
{
    if (jobcount>0) {
        NSString *jobcountstr=[NSString stringWithFormat:@"%@ Jobs",@(jobcount)];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobModel *jobModel = jobArray[indexPath.row];
    if(self.delegate && [self.delegate respondsToSelector:@selector(CompanyDetailJobsViewDidSelectAction:)]){
        [self.delegate CompanyDetailJobsViewDidSelectAction:jobModel.id];
    }
}

/**
 Refresh table data
 */
-(void)reloadData
{
    if (self->tableView) {
        [self->tableView reloadData];
    }
}

#pragma mark - 滑动方法
/**
 UIScrollViewDelegate
 scroll view did scroll
 Handling paged load data
 
 @param scrollView UIScrollView
 */
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
    
//    if(!isRefreshing
//       && scrollView.contentSize.height > scrollView.frame.size.height
//       && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)) ){
////        [self getDatas:YES];
//        [self.parentViewController.view makeToast:@"加载更多"];
//        
//        
//    }
    NSLog(@"companydetailscrollView");
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat consizeheight=scrollView.contentSize.height;
    if (consizeheight<height) {
        consizeheight=height;
    }
    CGFloat bottomOffset = (consizeheight - contentOffsetY);
    if (bottomOffset <= height-50)
    {
         NSLog(@"==================================下啦刷选;contentOffsetY=%@;consizeheight=%@;bottomOffset=%@;height=%@；",@(contentOffsetY),@(consizeheight),@(bottomOffset),@(height));
        if (!isRefreshing) {
            [self showLoading];
            self->isRefreshing=YES;
            [Proto getAllJobsByCompanyId:self.companyId skip:self->jobArray.count completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
                foreTask(^{
                    self->isRefreshing=NO;
                    [self hideLoading];
                    [self setJobCountTitle:totalCount];
                    NSLog(@"%@",array);
                    if(array && array.count>0){
                        NSMutableArray *temparr=[NSMutableArray arrayWithArray:self->jobArray];
                        [temparr addObjectsFromArray:array];
                        self->jobArray=[temparr copy];
                        [self->tableView reloadData];
                    }
                });
            }];
        }
        
    }
}
/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}
@end
