//
//  DiscussTableViewCell.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHStarRateView.h"
#import "DiscussInfo.h"

@interface DiscussTableViewCell : UITableViewCell

@property (strong, nonatomic)DiscussInfo *disInfo;
@property (strong, nonatomic)XHStarRateView *star;

@end
