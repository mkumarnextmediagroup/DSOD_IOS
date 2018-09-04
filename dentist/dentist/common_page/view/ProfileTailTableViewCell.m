//
//  ProfileTailTableViewCell.m
//  dentist
//
//  Created by wennan on 2018/9/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ProfileTailTableViewCell.h"
#import "Fonts.h"
#import "Common.h"

@implementation ProfileTailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatar = [UIImageView new];
        _avatar.frame = CGRectMake(18, 13, 48, 48);
        [self addSubview:_avatar];
        
        
        _specialityTitle = [UILabel new];
        _specialityTitle.frame = CGRectMake(78, 22, SCREENWIDTH - 78, 16);
        _specialityTitle.font = [Fonts semiBold:14];
        _specialityTitle.textColor = rgb255(0x4a,  0x4a,  0x4a);
        [self addSubview:_specialityTitle];
        
        
        _speciality = [UILabel new];
        _speciality.frame = CGRectMake(78, 42, SCREENWIDTH - 78, 14);
        _speciality.font = [Fonts regular:12];
        _speciality.textColor = rgb255(0x4a,  0x4a,  0x4a);
        [self addSubview:_speciality];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(Profile *) profile{

    _specialityTitle.text=profile.specialityTitle;
    _speciality.text=profile.speciality;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:profile.avatatUrl]
               placeholderImage:[UIImage imageNamed:profile.avataName]];
    
}

@end
