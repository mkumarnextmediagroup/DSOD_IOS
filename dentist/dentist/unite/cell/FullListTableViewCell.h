//
//  FullListTableViewCell.h
//  dentist
//
//  Created by 孙兴国 on 2018/11/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FullListTableViewCell : UITableViewCell

@property (nonatomic, assign)BOOL isLastInfo;

- (void)bindInfo:(DetailModel *)infoModel;

@end

NS_ASSUME_NONNULL_END
