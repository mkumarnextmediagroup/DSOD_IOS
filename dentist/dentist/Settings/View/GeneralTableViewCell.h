//
//  GeneralTableViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/11.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralTableViewCell : UITableViewCell

@property (nonatomic,assign) BOOL isSwitch;

-(void)setModel:(NSString *)title des:(NSString *)des status:(BOOL)status;
@end

NS_ASSUME_NONNULL_END
