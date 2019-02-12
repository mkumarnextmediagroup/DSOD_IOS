//
//  CompanyDetailReviewsViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyDetailReviewsViewController.h"
#import "Common.h"
#import "Proto.h"
#import "CompanyReviewModel.h"
#import "JobDSOModel.h"
#import "CompanyReviewHeaderTableViewCell.h"
#import "CompanyReviewTableViewCell.h"
#import "CareerAddReviewViewController.h"
#import "CompanyReviewsViewController.h"

@interface CompanyDetailReviewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CompanyDetailReviewsViewController{
    int edge;

    UITableView *tableView;
    
    NSArray<CompanyReviewModel*> *reviewArray;
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
 set JobDSOModel
 
 @param jobDSOModel JobDSOModel
 */
-(void)buildView{
    edge = 18;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.tableFooterView = [self buildFooterView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = [self edgeInsetsMake];
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = UIColor.whiteColor;
    [tableView registerClass:CompanyReviewHeaderTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
    [tableView registerClass:CompanyReviewTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    
}


/**
 set JobDSOModel
 
 @param jobDSOModel JobDSOModel
 */
-(void)setJobDSOModel:(JobDSOModel *)jobDSOModel{
    _jobDSOModel = jobDSOModel;
    [self reloadComment];
}

/**
 Reload comment data
 */
-(void)reloadComment{
    [Proto findCommentByCompanyId:self.jobDSOModel.id sort:0 star:0 skip:0 limit:5 completed:^(NSArray<CompanyReviewModel *> *reviewArray,NSInteger totalFound) {
            self->reviewArray = [reviewArray copy];
            [self->tableView reloadData];
    }];
}

/**
 获得最新的公司信息
 Get the latest dso information
 */
-(void)getNewJobDSOModel{
    [self showLoading];
    [Proto findCompanyById:self.jobDSOModel.id completed:^(JobDSOModel * _Nullable companyModel) {
        [self hideLoading];
        if(companyModel){
            self.jobDSOModel = companyModel;
        }
    }];
}

/**
 see more label click event
 jump to reviews list page
 */
-(void)seeMore{
    [CompanyReviewsViewController openBy:self.vc jobDSOModel:self.jobDSOModel];
}

/**
 Write review button click event
 jump to add review page
 */

-(void)writeReview{
    WeakSelf
    [CareerAddReviewViewController openBy:self.vc dsoId:self.jobDSOModel.id successCallbak:^{
        [weakSelf getNewJobDSOModel];
    }];
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 build tableview footer view
 see more label and write button
 
 @return UIView
 */
- (UIView *)buildFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100+edge)];
    
    UILabel *moreLabel = footerView.addLabel;
    moreLabel.text = @"see more";
    moreLabel.textColor = rgbHex(0x879aa8);
    moreLabel.font = [Fonts regular:16];
    [moreLabel onClick:self action:@selector(seeMore)];
    [[[[moreLabel.layoutMaker centerXParent:0]topParent:5] heightEq:45] install];
    
    UILabel *writeBtn = footerView.addLabel;
    writeBtn.text = @"Write review";
    writeBtn.textColor = rgbHex(0x4a4a4a);
    writeBtn.font = [Fonts regular:16];
    writeBtn.textAlignment = NSTextAlignmentCenter;
    writeBtn.layer.borderColor =rgbHex(0xdddddd).CGColor;
    writeBtn.layer.borderWidth = 2;
    [writeBtn onClick:self action:@selector(writeReview)];
    [[[[[[writeBtn.layoutMaker leftParent:edge]rightParent:-edge] below:moreLabel offset:5] bottomParent:-edge]heightEq:45] install];
    
    return footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count = 0;
    if(self.jobDSOModel){
        count = 1;
    }
    if(reviewArray && reviewArray.count>0){
        count += reviewArray.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return [self companyReviewHeaderCell:tableView data:self.jobDSOModel];
    }else{
        return [self companyReviewTableViewCell:tableView data:self->reviewArray[indexPath.row-1]];
    }
}

/**
 build dso info cell
 
 @param model JobDSOModel
 @return UITableViewCell
 */
-(UITableViewCell*)companyReviewHeaderCell:tableView data:(JobDSOModel*)model{
    CompanyReviewHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:model];
    return cell;
}

/**
 build dso reviews cell
 
 @param model CompanyReviewModel
 @return UITableViewCell
 */
-(UITableViewCell*)companyReviewTableViewCell:tableView data:(CompanyReviewModel*)model{
    CompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:model];
    return cell;
}


#pragma mark - 滑动方法
/**
 UIScrollViewDelegate
 scroll view did scroll
 
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
}

/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}

/**
 Get internal padding
 subview overwrite
 
 @return UIEdgeInsets
 */
-(UIEdgeInsets)edgeInsetsMake{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
