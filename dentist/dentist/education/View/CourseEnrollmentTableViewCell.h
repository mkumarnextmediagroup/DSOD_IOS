//
//  CourseEnrollmentTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2019/3/1.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMSEnrollmentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseEnrollmentTableViewCell : UITableViewCell
@property (nonatomic,strong) LMSEnrollmentModel *model;
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,assign) NSInteger startStatus;
@end

NS_ASSUME_NONNULL_END
