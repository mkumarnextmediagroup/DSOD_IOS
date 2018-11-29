//
//  DescriptionOfJobDetailTableViewCell.h
//  dentist
//
//  Created by Shirley on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DescriptionOfJobDetailTableViewCell : UITableViewCell

-(void)setData:(JobModel*)model;

@end

NS_ASSUME_NONNULL_END
