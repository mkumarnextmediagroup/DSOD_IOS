//
//  JobDetailCompanyViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailCompanyViewController : UIViewController


/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) void(^noScrollAction)(void) ;

-(void)contentOffsetToPointZero;

-(void)setData:(JobDSOModel* _Nullable)model;

@end

NS_ASSUME_NONNULL_END
