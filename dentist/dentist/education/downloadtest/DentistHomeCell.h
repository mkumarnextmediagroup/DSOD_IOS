//
//  DentistHomeCell.h
//  DentistProject
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DentistDownload.h"

@interface DentistHomeCell : UITableViewCell

@property (nonatomic, strong) DentistDownloadModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tabelView;

// 更新视图
- (void)updateViewWithModel:(DentistDownloadModel *)model;

@end
