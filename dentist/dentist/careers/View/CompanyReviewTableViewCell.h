//
//  CompanyReviewTableViewCell.h
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyCommentReviewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyReviewTableViewCell : UITableViewCell

-(void)setData:(CompanyCommentReviewsModel*)model;

@end

NS_ASSUME_NONNULL_END
