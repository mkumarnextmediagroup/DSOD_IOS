//
//  CourseDescriptionViewController.h
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDescriptionViewController : UIViewController

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



@property (nonatomic,weak) UIViewController *vc;

/**
 show course info
 description、author info、lesson

 @param courseModel CourseModel instance
 */
-(void)showData:(CourseModel*)courseModel;

@end

NS_ASSUME_NONNULL_END
