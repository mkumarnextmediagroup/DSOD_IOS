//
//  CompanyReviewHeaderTableViewCell.h
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyReviewHeaderTableViewCell : UITableViewCell

- (void)setData:(JobDSOModel *)model;

@end

NS_ASSUME_NONNULL_END
