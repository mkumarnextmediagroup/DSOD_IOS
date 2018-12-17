//
//  CompanyDetailJobsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@protocol CompanyDetailJobsViewDelegate <NSObject>
@optional
- (void)CompanyDetailJobsViewDidSelectAction:(NSString *)jobId;

@end

@interface CompanyDetailJobsViewController : UIViewController

@property (nonatomic,strong) NSString *companyId;
@property (nonatomic,weak) id<CompanyDetailJobsViewDelegate>delegate;



/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) void(^noScrollAction)(void) ;

-(void)contentOffsetToPointZero;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
