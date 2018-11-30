//
//  FindJobsSponsorTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"
@interface FindJobsSponsorTableViewCell : UITableViewCell
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,copy) JobModel *info;
@end
