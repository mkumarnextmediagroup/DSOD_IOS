//
//  CareerAlertsTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobAlertsModel.h"

@protocol CareerAlertsTableViewCellDelegate <NSObject>

@optional
- (void)JobAlertsAction:(JobAlertsModel *)model;
- (void)JobAlertsEditAction:(JobAlertsModel *)model;
@end
@interface CareerAlertsTableViewCell : UITableViewCell
@property (nonatomic,strong) JobAlertsModel *alerModel;
@property (nonatomic,weak) id<CareerAlertsTableViewCellDelegate> delegate;
@end

