//
//  GeneralTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/11.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GeneralTableViewCellDelegate <NSObject>
@optional
- (void)SwitchChangeAction:(BOOL)status indexPath:(NSIndexPath *)indexPath view:(UIView *)view;
@end

NS_ASSUME_NONNULL_BEGIN

@interface GeneralTableViewCell : UITableViewCell
@property (nonatomic,copy) NSIndexPath *indexPath;
@property (nonatomic,assign) BOOL isSwitch;
@property (nonatomic,assign) BOOL isShowTopLine;
@property (nonatomic,weak) id<GeneralTableViewCellDelegate>delegate;

-(void)setModel:(NSString *)title des:(NSString *)des status:(BOOL)status;
-(void)setModelSwitch:(BOOL)status;
-(void)styleGlay;

@end

NS_ASSUME_NONNULL_END
