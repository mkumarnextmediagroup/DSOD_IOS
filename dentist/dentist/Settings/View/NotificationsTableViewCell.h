//
//  NotificationsTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/8.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NotificationsTableViewCellDelegate <NSObject>
@optional
- (void)SwitchChangeAction:(BOOL)status indexPath:(NSIndexPath *)indexPath view:(UIView *)view;
@end

NS_ASSUME_NONNULL_BEGIN

@interface NotificationsTableViewCell : UITableViewCell
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,weak) id<NotificationsTableViewCellDelegate>delegate;
-(void)setModel:(NSString *)title des:(NSString *)des status:(BOOL)status;
-(void)setModelSwitch:(BOOL)status;
@end

NS_ASSUME_NONNULL_END
