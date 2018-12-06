//
//  JobsOfDSODetailTableViewCell.h
//  dentist
//
//  Created by Shirley on 2018/12/3.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyJobsModel.h"
#import "JobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsOfDSODetailTableViewCell : UITableViewCell
@property (nonatomic,strong) CompanyJobsModel *companyJobsModel;
@property (nonatomic,strong) NSMutableArray *infoArr;
@property (nonatomic,assign) NSInteger totalCount;

@end

NS_ASSUME_NONNULL_END
