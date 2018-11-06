//
//  ThumAndDetailViewController.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThumAndDetailViewControllerDelegate <NSObject>

@optional
- (void)ThumAndDetailViewControllerDidScroll:(CGFloat)offsety;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ThumAndDetailViewController : UIViewController
@property (nonatomic,copy) void(^scrollToDown)(CGFloat y);
@property (nonatomic,weak) id<ThumAndDetailViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
