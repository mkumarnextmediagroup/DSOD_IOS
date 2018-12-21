//
//  CareerAlertsAddViewController.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobAlertsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CareerAlertsAddViewController : UIViewController
@property (nonatomic,copy) JobAlertsModel *model;
@property (nonatomic,copy) void(^alertsAddSuceess)(JobAlertsModel *oldmodel,JobAlertsModel *newmodel);
@end

NS_ASSUME_NONNULL_END
