//
//  DSOProfileTableViewCell.h
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSOProfileTableViewCell : UITableViewCell

- (void)bindInfo:(JobModel *)modelInfo;

@end

NS_ASSUME_NONNULL_END
