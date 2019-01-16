//
//  SettingTableViewCell.h
//  dentist
//
//  Created by Jacksun on 2019/1/4.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell

- (void)setImageAndTitle:(UIImage *)image title:(NSString *)title;

- (void)setLastCellImageAndTitle:(UIImage *)image title:(NSString *)title;

-(void)styleGlay;

@end

NS_ASSUME_NONNULL_END
