//
//  SwitchTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/9/4.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "SwitchTableViewCell.h"
#import "Fonts.h"
#import "Colors.h"

@implementation SwitchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = localStr(@"attended");
        titleLab.font = [Fonts regular:12];
        titleLab.textColor = Colors.textAlternate;
        [self addSubview:titleLab];
        [[[titleLab.layoutMaker sizeEq:200 h:49] leftParent:16] install];
        
        _onSwitch = [[UISwitch alloc] init];
        [self addSubview:_onSwitch];
        _onSwitch.on = YES;
        [[[[_onSwitch.layoutMaker sizeEq:51 h:31] topParent:9] rightParent:-20] install];
        _onSwitch.tintColor = Colors.bgDisabled;
        _onSwitch.onTintColor = Colors.textDisabled;
        
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
