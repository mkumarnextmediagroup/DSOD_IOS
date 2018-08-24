//
//  MagazineTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/8/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "MagazineTableViewCell.h"
#import "Fonts.h"

@implementation MagazineTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.frame = CGRectMake(0, 0, 80, 49);
        [_phoneBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        [self addSubview:_phoneBtn];
        
        _notice = [UILabel new];
        _notice.frame = CGRectMake(80, 0, SCREENWIDTH - 100, 49);
        _notice.font = [Fonts regular:13];
        _notice.textColor = [UIColor lightGrayColor];
        [self addSubview:_notice];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(SCREENWIDTH - 80, 0, 80, 49);
        [_deleteBtn setImage:[UIImage imageNamed:@"close_select"] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
        _deleteBtn.hidden = YES;
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

@end
