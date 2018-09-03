//
//  ProfileHeaderTableViewCell.h
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Profile.h"

@interface ProfileHeaderTableViewCell : UITableViewCell
@property (strong, nonatomic)UIImageView *avatar;
@property (strong, nonatomic)UILabel *name;
@property (strong, nonatomic)UILabel *specialityTitle;
@property (strong, nonatomic)UILabel *speciality;

- (void)setData:(Profile *) profile;

@end
