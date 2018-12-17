//
//  FindJobsTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/29.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"
#import "JobsTableCellDelegate.h"
@interface FindJobsTableViewCell : UITableViewCell
@property (nonatomic,copy) JobModel *info;
@property (nonatomic,copy) NSDictionary *infoDic;
@property (nonatomic,assign) BOOL isHideNew;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,assign) BOOL follow;
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,copy) NSString *followid;
@property (nonatomic,weak) id<JobsTableCellDelegate>delegate;
-(void)updateFollowStatus:(BOOL)isfllow;
@end

