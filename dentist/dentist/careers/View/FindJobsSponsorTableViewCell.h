//
//  FindJobsSponsorTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"
#import "JobsTableCellDelegate.h"
@interface FindJobsSponsorTableViewCell : UITableViewCell
@property (nonatomic,assign) BOOL isHideNew;
@property (nonatomic,assign) BOOL follow;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,assign) BOOL isApply;
@property (nonatomic,copy) JobModel *info;
@property (nonatomic,copy) NSString *followid;
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,weak) id<JobsTableCellDelegate>delegate;

-(void)updateFollowStatus:(BOOL)isfllow;
-(void)setIsNew:(BOOL)isNew;
-(void)setInfo:(JobModel *)info;
-(void)followAction:(UIButton *)sender;
@end
