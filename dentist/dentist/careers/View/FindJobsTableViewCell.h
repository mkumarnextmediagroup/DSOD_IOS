//
//  FindJobsTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/29.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"

@interface FindJobsTableViewCell : UITableViewCell
@property (nonatomic,copy) JobModel *info;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,assign) BOOL isDetail;
@end

