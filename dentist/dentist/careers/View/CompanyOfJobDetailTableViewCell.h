//
//  CompanyOfJobDetailTableViewCell.h
//  dentist
//
//  Created by Shirley on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"
#import "CompanyJobsModel.h"
#import "JobModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CompanyOfJobDetailTableViewCell : UITableViewCell
@property (nonatomic,strong) CompanyJobsModel *companyJobsModel;
@property (nonatomic,strong) NSMutableArray *infoArr;
@property (nonatomic,assign) NSInteger totalCount;
-(void)setData:(CompanyModel*)model;


@end

NS_ASSUME_NONNULL_END
