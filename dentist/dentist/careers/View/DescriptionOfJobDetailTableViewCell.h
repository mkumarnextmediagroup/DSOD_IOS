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

@property (nonatomic,assign) UITableView *tableView;


-(void)setData:(JobModel*)model;

//sub class use
-(void)showContent:(NSString*)html;

@end

NS_ASSUME_NONNULL_END
