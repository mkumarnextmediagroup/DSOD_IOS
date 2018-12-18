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
#import "CompanyCommentReviewsModel.h"
#import "CompanyReviewHeaderTableViewCell.h"
#import "CompanyReviewTableViewCell.h"
#import "CareerAddReviewViewController.h"

@interface CompanyDetailReviewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CompanyDetailReviewsViewController{
    int edge;

    UITableView *tableView;
    
    CompanyCommentModel *companyCommentModel;
    NSArray<CompanyCommentReviewsModel*> *commentArray;
}



- (void)viewDidLoad{
    edge = 18;
    [self buildView];
    
}


-(void)buildView{
    edge = 18;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [tableView registerClass:CompanyReviewHeaderTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
    [tableView registerClass:CompanyReviewTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    
}



-(void)setCompanyId:(NSString *)companyId{
    _companyId=companyId;
//    [Proto findCommentByCompanyId:self.companyId sort:0 star:0 skip:0 limit:2 completed:^(CompanyCommentModel * _Nullable companyCommentModel) {
//        self->companyCommentModel = companyCommentModel;
//        self->commentArray = companyCommentModel.reviews;
//        [self->tableView reloadData];
//    }];
}

-(void)seeMore{
    
}

-(void)writeReview{
    WeakSelf
    [CareerAddReviewViewController openBy:self.vc dsoId:self.companyId successCallbak:^{
        [weakSelf setCompanyId:weakSelf.companyId];
    }];
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CGFLOAT_MIN)];
    
    UILabel *moreLabel = footerView.addLabel;
    moreLabel.text = @"see more";
    moreLabel.textColor = rgbHex(0x879aa8);
    moreLabel.font = [Fonts regular:16];
    [moreLabel onClick:self action:@selector(seeMore)];
    [[[[moreLabel.layoutMaker centerXParent:0]topParent:edge] heightEq:45] install];
    
    UILabel *writeBtn = footerView.addLabel;
    writeBtn.text = @"Write review";
    writeBtn.textColor = rgbHex(0x4a4a4a);
    writeBtn.font = [Fonts regular:16];
    writeBtn.textAlignment = NSTextAlignmentCenter;
    writeBtn.layer.borderColor =rgbHex(0xdddddd).CGColor;
    writeBtn.layer.borderWidth = 2;
    [writeBtn onClick:self action:@selector(writeReview)];
    [[[[[[writeBtn.layoutMaker leftParent:edge]rightParent:-edge] below:moreLabel offset:edge] bottomParent:-edge]heightEq:45] install];
    
    return footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count = 0;
    if(companyCommentModel){
        count = 1;
    }
    if(commentArray && commentArray.count>0){
        count += commentArray.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return [self companyReviewHeaderCell:tableView data:self->companyCommentModel];
    }else{
        return [self companyReviewTableViewCell:tableView data:self->commentArray[indexPath.row-1]];
    }
}

-(UITableViewCell*)companyReviewHeaderCell:tableView data:(CompanyCommentModel*)model{
    CompanyReviewHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:model];
    return cell;
}


-(UITableViewCell*)companyReviewTableViewCell:tableView data:(CompanyCommentReviewsModel*)model{
    CompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CompanyReviewTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:model];
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
}

-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}

@end
