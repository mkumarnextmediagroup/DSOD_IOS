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

@protocol CourseTableViewCellDelegate <NSObject>

@optional
- (void)sponsoredAction:(NSIndexPath *)indexPath;
@end

@interface CourseTableViewCell : UITableViewCell

@property (nonatomic,strong) GenericCoursesModel *model;
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,assign) BOOL isHideSponsor;
@property (nonatomic,weak) id<CourseTableViewCellDelegate> detegate;


@property (nonatomic,weak) UIViewController *vc;
@property (nonatomic, copy) void(^bookmarkStatusChanged)(GenericCoursesModel *model) ;
@end

NS_ASSUME_NONNULL_END
