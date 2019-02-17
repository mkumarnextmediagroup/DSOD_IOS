//
//  CourseTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericCoursesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseTableViewCell : UITableViewCell
@property (nonatomic,strong) GenericCoursesModel *model;
@end

NS_ASSUME_NONNULL_END
