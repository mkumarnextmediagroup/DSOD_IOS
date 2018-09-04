//
//  ProfileHeaderTableViewCell.m
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ProfileHeaderTableViewCell.h"
#import "Fonts.h"
#import "Common.h"

@implementation ProfileHeaderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatar = [UIImageView new];
        _avatar.frame = CGRectMake(17, 12, 70, 70);
       
        [self addSubview:_avatar];
        
        _name = [UILabel new];
        _name.frame = CGRectMake(102, 15, SCREENWIDTH - 102, 20);
        _name.font = [Fonts semiBold:17];
        _name.textColor = [UIColor blackColor];
        
        [self addSubview:_name];
      
        
        _specialityTitle = [UILabel new];
        _specialityTitle.frame = CGRectMake(102, 46, SCREENWIDTH - 102, 14);
        _specialityTitle.font = [Fonts regular:12];
        _specialityTitle.textColor = rgb255(0x9b,  0x9b,  0x9b);
        
        [self addSubview:_specialityTitle];
        
        
        _speciality = [UILabel new];
        _speciality.frame = CGRectMake(102, 64, SCREENWIDTH - 102, 16);
        _speciality.font = [Fonts semiBold:14];
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
    _name.text=profile.name;
     _specialityTitle.text=profile.specialityTitle;
     _speciality.text=profile.speciality;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:profile.avatatUrl]
               placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
}

@end
