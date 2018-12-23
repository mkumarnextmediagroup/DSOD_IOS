//
//  CompanyReviewsCell.h
//  dentist
//
//  Created by Shirley on 2018/12/22.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyReviewModel.h"
#import "JobDSOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyReviewsCell : UITableViewCell

-(void)setData:(CompanyReviewModel*)model jobDSOModel:(JobDSOModel*)jobDSOModel seeMoreListener:(void(^)(JobDSOModel*jobDSOModel,CompanyReviewModel*reviewModel))seeMoreListener;

@end

NS_ASSUME_NONNULL_END
