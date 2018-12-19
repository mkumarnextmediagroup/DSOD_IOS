//
//  CompanyDetailReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyDetailReviewsViewController : UIViewController

@property (nonatomic,assign) UIViewController *vc;
@property (nonatomic,strong) JobDSOModel *jobDSOModel;

/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) void(^noScrollAction)(void) ;

-(void)contentOffsetToPointZero;

@end

NS_ASSUME_NONNULL_END
