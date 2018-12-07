//
//  DSODetailPage.m
//  dentist
//
//  Created by Jacksun on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DSODetailPage.h"
#import "Common.h"
#import "UIView+Toast.h"
#import "CompanyModel.h"
#import "JobModel.h"
#import "Proto.h"
#import "DentistTabView.h"
#import "UIView+Toast.h"
#import "DescriptionOfDSODetailTableViewCell.h"
#import "JobsOfDSODetailTableViewCell.h"
#import "CompanyJobsModel.h"
#import "BannerScrollView.h"
#import "FindJobsTableViewCell.h"
#import "CareerSearchViewController.h"
#import "CareerJobDetailViewController.h"
#import "FilterView.h"

@interface DSODetailPage ()<UITableViewDelegate,UITableViewDataSource,DentistTabViewDelegate,FilterViewDelegate>

@end


@implementation DSODetailPage{


    UIView *contentView;
    UITableView *tableView;

    BannerScrollView *bannerView;
    UIImageView *singleImageView;
    
    UIView *sectionHeaderView;

    int edge;
    int currTabIndex;//0:description 1:company 2:reviews

    CompanyModel *companyModel;
    NSArray<JobModel*> *jobArray;
    BOOL isdownrefresh;
    UILabel *jobCountTitle;
    UIView *filterView;
    NSDictionary *filterDic;
}



+(void)openBy:(UIViewController*)vc companyId:(NSString*)companyId{
    if(companyId){

        DSODetailPage *DSODetailPageVc = [DSODetailPage new];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:DSODetailPageVc];
        DSODetailPageVc.companyId = companyId;
        [vc presentViewController:navVC animated:YES completion:NULL];
    }else{
        [vc.view makeToast:@"companyId is null"];
    }
}

- (void)viewDidLoad {
    edge = 18;
    
    [super viewDidLoad];
    
    contentView  = self.view.addView;
    [[[[[contentView.layoutMaker leftParent:0]rightParent:0] topParent:NAVHEIGHT]bottomParent:0] install];
    contentView.backgroundColor = UIColor.whiteColor;
    
    [self addNavBar];
    
    [self showLoading];
    
    [Proto findCompanyById:self.companyId completed:^(CompanyModel * _Nullable companyModel) {
        [self hideLoading];
        if(companyModel){
            self->companyModel = companyModel;
            [self buildView];
        }
    }];
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"DSO COMPANY";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)buildView{
    tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [contentView addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    tableView.tableHeaderView =[self buildHeader];
    [[[tableView.tableHeaderView.layoutUpdate topParent:0]leftParent:0] install];
    [tableView registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
    
}


-(UIView*)buildHeader{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CGFLOAT_MIN)];
    
    bannerView = [BannerScrollView new];
    [headerView addSubview:bannerView];
    [[[[[bannerView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH h:SCREENWIDTH/2]install];
    
    
    singleImageView= headerView.addImageView;
    [singleImageView scaleFillAspect];
    singleImageView.clipsToBounds = YES;
    [[[[[singleImageView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH h:SCREENWIDTH/2]install];
    
    
    UIImageView *logoImageView = headerView.addImageView;
    [logoImageView scaleFillAspect];
    logoImageView.clipsToBounds = YES;
    [[[[logoImageView.layoutMaker leftParent:edge]below:bannerView offset:10] sizeEq:60 h:60]install];
    
    
    UILabel *companyLabel = headerView.addLabel;
    companyLabel.font = [Fonts semiBold:16];
    [[[[companyLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:-edge] below:bannerView offset:10]install] ;
    
    
    UIButton *addressBtn = headerView.addButton;
    addressBtn.titleLabel.font = [Fonts regular:12];
    [addressBtn setTitleColor:Colors.textMain forState:UIControlStateNormal];
    [addressBtn onClick:self action:@selector(showLocation)];
    addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 50);
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"career_location_bg_small"] forState:UIControlStateNormal];
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"career_location_bg_samll"] forState:UIControlStateHighlighted];
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addressBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addressBtn.titleLabel.numberOfLines = 3;
    [[[[[addressBtn.layoutMaker below:companyLabel offset:10] toRightOf:logoImageView offset:10]rightParent:-edge] heightEq:42]install];
    
    
    UIView *lastView = headerView.addView;
    [[[[[lastView.layoutMaker below:addressBtn offset:0]leftParent:0]rightParent:0]heightEq:10]install];
    
    
    
    if(companyModel.media){
        NSArray *urls = companyModel.media.companyPictureUrl;
        if(companyModel.media.type == 1 && urls && urls.count > 0 ){
            if(urls.count>1){
                [bannerView addWithImageUrls:urls autoTimerInterval:3 clickBlock:^(NSInteger index) {
                    
                }];
            }else{
                [singleImageView loadUrl:urls[0] placeholderImage:nil];
            }
        }
    }
    
    
    [logoImageView loadUrl:companyModel.companyLogoUrl placeholderImage:nil];
    companyLabel.text = companyModel.companyName;
    [addressBtn setTitle:companyModel.address forState:UIControlStateNormal];


    
    
    
    [headerView.layoutUpdate.bottom.equalTo(lastView.mas_bottom) install];
    [headerView layoutIfNeeded];
    
    
    return headerView;
}



- (void)searchClick{
    CareerSearchViewController *searchVC=[CareerSearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)showLocation{
    [self.view makeToast:@"showLocation"];
}



#pragma mark DentistTabViewDelegate
- (void)didDentistSelectItemAtIndex:(NSInteger)index{
    currTabIndex = (int)index;
    if (currTabIndex==1) {
        [self showLoading];
        [Proto getAllJobsByCompanyId:self.companyId skip:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
            foreTask(^{
                [self hideLoading];
                [self setJobCountTitle:totalCount];
                self->jobArray = array;
                [self->tableView reloadData];
            });
        }];
//        [Proto queryAllJobs:0 completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
//            foreTask(^{
//                [self hideLoading];
//                self->jobArray = array;
//                [self->tableView reloadData];
//            });
//        }];
    }
    [tableView reloadData];
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

-(void)clickFilter:(UIButton *)sender
{
    FilterView *filterview=[FilterView initFilterView];
    filterview.delegate=self;
    [filterview showFilter];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (currTabIndex==1) {
        return 82;
    }else{
       return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(!sectionHeaderView){
        sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 82)];


        DentistTabView *tabView = [DentistTabView new];
        tabView.isScrollEnable=NO;
        tabView.itemCount=3;
        tabView.delegate=self;
        [sectionHeaderView addSubview:tabView];
        [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:50] install];
        tabView.titleArr=[NSMutableArray arrayWithArray:@[@"DESCRIPTION",@"JOBS",@"REVIEWS"]];
        
        filterView = sectionHeaderView.addView;
        [[[[[filterView.layoutMaker leftParent:0] rightParent:0] below:tabView offset:0] heightEq:32]  install];
        filterView.backgroundColor=[UIColor whiteColor];
        
        jobCountTitle=filterView.addLabel;
        jobCountTitle.textColor =Colors.textMain;
        jobCountTitle.font=[Fonts semiBold:13];
        [[[[[jobCountTitle.layoutMaker leftParent:20] topParent:0] bottomParent:0] rightParent:40] install];
        
        UIButton *filterButton = [filterView addButton];
        [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
        [[[[filterButton.layoutMaker topParent:4] rightParent:-15] sizeEq:24 h:24] install];
        [filterButton onClick:self action:@selector(clickFilter:)];
        UILabel *lineLabel=filterView.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    if (currTabIndex==1) {
        filterView.hidden=NO;
        sectionHeaderView.frame=CGRectMake(0, 0, SCREENWIDTH, 82);
    }else{
        filterView.hidden=YES;
        sectionHeaderView.frame=CGRectMake(0, 0, SCREENWIDTH, 50);
    }
    return sectionHeaderView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (currTabIndex) {
        case 0:
            return 1 ;
        case 1:
            return self->jobArray.count;
        case 2:
            return 60;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    
    switch (currTabIndex) {
        case 0:
            return [self descriptionOfDSODetailTableViewCell:tableView data:self->companyModel];
        case 1:
            return [self jobsOfDSODetailTableViewCell:tableView data:self->jobArray cellForRowAtIndexPath:indexPath];
        case 2:
//            return [self companyReviewHeaderCell:tableView data:self->companyCommentModel];
        default:
            break;
    }
    
    cell.textLabel.text = @"aa";
    return cell;
}

-(UITableViewCell*)descriptionOfDSODetailTableViewCell:tableView data:(CompanyModel*)model{
    DescriptionOfDSODetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionOfDSODetailTableViewCell"];
    if (cell == nil) {
        cell = [[DescriptionOfDSODetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionOfDSODetailTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tableView = tableView;
    [cell setData:model];
    return cell;
}


-(UITableViewCell*)jobsOfDSODetailTableViewCell:tableView data: (NSArray<JobModel*> *)jobArray{
    JobsOfDSODetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobsOfDSODetailTableViewCell"];
    if (cell == nil) {
        cell = [[JobsOfDSODetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JobsOfDSODetailTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.infoArr=[NSMutableArray arrayWithArray:jobArray];
    cell.totalCount=jobArray.count;
    return cell;
}

-(UITableViewCell*)jobsOfDSODetailTableViewCell:tableView data: (NSArray<JobModel*> *)jobArray cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
//    cell.delegate=self;
    cell.indexPath=indexPath;
    if (jobArray && jobArray.count>indexPath.row) {
        
        cell.info=jobArray[indexPath.row];
    }
    return cell;
}

//
//-(UITableViewCell*)companyReviewHeaderCell:tableView data:(CompanyCommentModel*)model{
//    CompanyReviewHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyReviewHeaderTableViewCell"];
//    if (cell == nil) {
//        cell = [[CompanyReviewHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyReviewHeaderTableViewCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    [cell setData:model];
//    return cell;
//}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (currTabIndex==1 && self->jobArray.count>0) {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat consizeheight=scrollView.contentSize.height;
        CGFloat bottomOffset = (consizeheight - contentOffsetY);

        CGFloat offsetY = scrollView.contentOffset.y;
        
        // 当最后一个cell完全显示在眼前时，contentOffset的y值
        CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - height;
//        if (offsetY > judgeOffsetY+50 && judgeOffsetY>0) {
//            if (!isdownrefresh) {
//                NSLog(@"==================================下啦刷选;offsetY=%@;judgeOffsetY=%@",@(offsetY),@(judgeOffsetY));
////                NSLog(@"==================================下啦刷选;bottomOffset=%@;height-50=%@",@(bottomOffset),@(height-50));
//                isdownrefresh=YES;
//                [self->tableView setContentOffset:CGPointMake(0, offsetY-50) animated:NO];
//                [self showIndicator];
//                [Proto getAllJobsByCompanyId:self.companyId skip:self->jobArray.count completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
//                    foreTask(^{
//                        [self hideIndicator];
//                         [self setJobCountTitle:totalCount];
//                        NSMutableArray *temparr=[NSMutableArray arrayWithArray:self->jobArray];
//                        NSLog(@"%@",array);
//                        if(array && array.count>0){
//                            [temparr addObjectsFromArray:array];
//                        }
//                        self->jobArray=[temparr copy];
//                        [self->tableView reloadData];
//                        
//                        self->isdownrefresh=NO;
//                        
//                    });
//                }];
//                
//            }
//        }
//        if (bottomOffset <= height-50 && contentOffsetY>0)
//        {
//
//
//
//        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (currTabIndex==1 && self->jobArray.count>indexPath.row) {
        JobModel *jobModel = jobArray[indexPath.row];
        [CareerJobDetailViewController presentBy:self jobId:jobModel.id closeBack:^{
            foreTask(^{
                if (self->tableView) {
                    [self->tableView reloadData];
                }
            });
            
        }];
    }
}

#pragma mark ----------------FilterViewDelegate
-(void)searchCondition:(NSDictionary *)condition
{
    NSLog(@"condition=%@",condition);
    filterDic=condition;
//    [self refreshData];
}

@end
