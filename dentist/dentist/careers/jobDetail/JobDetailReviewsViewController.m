//
//  JobDetailReviewsViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JobDetailReviewsViewController.h"
#import "Common.h"
#import "Proto.h"
#import "CompanyCommentModel.h"
#import "CompanyCommentReviewsModel.h"

@interface JobDetailReviewsViewController ()

@end

@implementation JobDetailReviewsViewController{
    CompanyCommentModel *companyCommentModel;
    NSArray<CompanyCommentReviewsModel*> *commentArray;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
//    [self showLoading];
//    [Proto findCommentByCompanyId:jobModel.companyId sort:0 star:0 skip:0 limit:2 completed:^(CompanyCommentModel * _Nullable companyCommentModel) {
//        [self hideLoading];
//        self->companyCommentModel = companyCommentModel;
//        self->commentArray = companyCommentModel.reviews;
//        [self->tableView reloadData];
//    }];
}


@end
