//
//  UniteArticleTableViewCell.h
//  dentist
//
//  Created by Jacksun on 2018/11/5.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniteArticleTableViewCell : UITableViewCell

- (void)bindInfo:(NSArray *)infoArr;

- (void)bindSearchInfo:(DetailModel *)infoModel;

@end

NS_ASSUME_NONNULL_END
