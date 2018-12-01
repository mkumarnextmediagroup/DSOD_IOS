//
//  JobsTableCellDelegate.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JobsTableCellDelegate <NSObject>
@optional
- (void)FollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view;
- (void)UnFollowJobAction:(NSIndexPath *)indexPath view:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
