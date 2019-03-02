//
//  CourseEnrollmentTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2019/3/1.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericCoursesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseEnrollmentTableViewCell : UITableViewCell
@property (nonatomic,strong) GenericCoursesModel *model;
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,assign) BOOL isHideSponsor;
@end

NS_ASSUME_NONNULL_END
