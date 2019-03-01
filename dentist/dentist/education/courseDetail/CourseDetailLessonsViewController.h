//
//  CourseDetailLessonViewController.h
//  dentist
//
//  Created by Shirley on 2019/2/17.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailLessonsViewController : UIViewController

// 是否可以滑动
//Is it currently possible to scroll
@property (nonatomic, assign) BOOL isCanScroll;
// 不滑动事件
// Callback function when scrolling is not possible
@property (nonatomic, copy) void(^noScrollAction)(void) ;

/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero;


/**
 show lessons info
 
 @param courseModel CourseModel instance
 */
-(void)showData:(CourseModel*)courseModel;



@end

NS_ASSUME_NONNULL_END
