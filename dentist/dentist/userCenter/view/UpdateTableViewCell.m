//
//  UpdateTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UpdateTableViewCell.h"

@implementation UpdateTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(SCREENWIDTH - 80, 0, 80, 44);
        [_selectBtn setImage:[UIImage imageNamed:@"unSelect"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateHighlighted];
        [self addSubview:_selectBtn];
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
